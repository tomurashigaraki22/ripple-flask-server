from flask import Blueprint, request, jsonify
import pymysql
import uuid
import jwt
import os
from datetime import datetime
from extensions.extensions import get_db_connection

storefront_reviews_bp = Blueprint("storefront_reviews", __name__)

# JWT_SECRET with fallback
JWT_SECRET = os.getenv("JWT_SECRET", "supersecret")

def verify_token():
    """Verify JWT token from request headers"""
    auth_header = request.headers.get("Authorization")

    if not auth_header or not auth_header.startswith("Bearer "):
        return jsonify({"error": "Missing or invalid authorization header"}), 401

    token = auth_header.split(" ")[1]

    try:
        decoded = jwt.decode(token, JWT_SECRET, algorithms=["HS256"])
    except jwt.ExpiredSignatureError:
        return jsonify({"error": "Token has expired"}), 401
    except jwt.InvalidTokenError:
        return jsonify({"error": "Invalid token"}), 401

    # Try both 'id' and 'userId' for compatibility
    user_id = decoded.get("id") or decoded.get("userId")
    if not user_id:
        return jsonify({"error": "Invalid token payload"}), 401

    # Fetch user from database using DictCursor
    try:
        conn = get_db_connection()
        cursor = conn.cursor(pymysql.cursors.DictCursor)
        cursor.execute(
            "SELECT id, email, username FROM users WHERE id = %s",
            (user_id,)
        )
        user = cursor.fetchone()
        cursor.close()
        conn.close()

        if not user:
            return jsonify({"error": "User not found"}), 404

        return user  # Return user dict directly for success case

    except Exception as e:
        print("DB error in verify_token:", e)
        return jsonify({"error": "Internal server error"}), 500

def create_reviews_table():
    """Create the storefront_reviews table if it doesn't exist"""
    conn = get_db_connection()
    try:
        cursor = conn.cursor()
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS storefront_reviews (
                id VARCHAR(36) PRIMARY KEY,
                storefront_id VARCHAR(36) NOT NULL,
                customer_name VARCHAR(255) NOT NULL,
                email VARCHAR(255) NOT NULL,
                rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
                title VARCHAR(500) NOT NULL,
                comment TEXT NOT NULL,
                product_name VARCHAR(255),
                verified BOOLEAN DEFAULT FALSE,
                helpful_count INT DEFAULT 0,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                status ENUM('pending', 'approved', 'rejected') DEFAULT 'pending',
                INDEX idx_storefront_id (storefront_id),
                INDEX idx_rating (rating),
                INDEX idx_created_at (created_at),
                INDEX idx_status (status)
            )
        """)
        conn.commit()
        cursor.close()
        print("Reviews table created successfully")
    except Exception as e:
        print(f"Error creating reviews table: {e}")
    finally:
        conn.close()

# Create table on import
create_reviews_table()

@storefront_reviews_bp.route("/submit", methods=["POST"])
def submit_review():
    """Submit a new review for a storefront"""
    try:
        data = request.get_json()
        
        # Validate required fields
        required_fields = ['storefront_id', 'customer_name', 'email', 'rating', 'title', 'comment']
        for field in required_fields:
            if not data.get(field):
                return jsonify({"error": f"Missing required field: {field}"}), 400
        
        # Validate rating range
        rating = int(data.get('rating'))
        if rating < 1 or rating > 5:
            return jsonify({"error": "Rating must be between 1 and 5"}), 400
        
        # Validate email format (basic)
        email = data.get('email')
        if '@' not in email or '.' not in email:
            return jsonify({"error": "Invalid email format"}), 400
        
        conn = get_db_connection()
        cursor = conn.cursor(pymysql.cursors.DictCursor)
        
        # Check if storefront exists (optional validation)
        cursor.execute("SELECT id FROM users WHERE id = %s", (data.get('storefront_id'),))
        storefront = cursor.fetchone()
        if not storefront:
            cursor.close()
            conn.close()
            return jsonify({"error": "Storefront not found"}), 404
        
        # Generate review ID
        review_id = str(uuid.uuid4())
        
        # Insert review
        cursor.execute("""
            INSERT INTO storefront_reviews 
            (id, storefront_id, customer_name, email, rating, title, comment, product_name, created_at)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
        """, (
            review_id,
            data.get('storefront_id'),
            data.get('customer_name'),
            email,
            rating,
            data.get('title'),
            data.get('comment'),
            data.get('product_name', ''),
            datetime.utcnow()
        ))
        
        conn.commit()
        cursor.close()
        conn.close()
        
        return jsonify({
            "message": "Review submitted successfully",
            "review_id": review_id
        }), 201
        
    except ValueError:
        return jsonify({"error": "Invalid rating value"}), 400
    except Exception as e:
        print(f"Error submitting review: {e}")
        return jsonify({"error": "Internal server error"}), 500

@storefront_reviews_bp.route("/storefront/<storefront_id>", methods=["GET"])
def get_storefront_reviews(storefront_id):
    """Get all approved reviews for a specific storefront"""
    try:
        # Get query parameters
        page = int(request.args.get('page', 1))
        limit = int(request.args.get('limit', 10))
        sort_by = request.args.get('sort', 'newest')  # newest, oldest, highest, lowest, helpful
        
        # Validate pagination
        if page < 1 or limit < 1 or limit > 100:
            return jsonify({"error": "Invalid pagination parameters"}), 400
        
        offset = (page - 1) * limit
        
        # Determine sort order
        sort_mapping = {
            'newest': 'created_at DESC',
            'oldest': 'created_at ASC',
            'highest': 'rating DESC, created_at DESC',
            'lowest': 'rating ASC, created_at DESC',
            'helpful': 'helpful_count DESC, created_at DESC'
        }
        order_by = sort_mapping.get(sort_by, 'created_at DESC')
        
        conn = get_db_connection()
        cursor = conn.cursor(pymysql.cursors.DictCursor)
        
        # Get total count
        cursor.execute(
            "SELECT COUNT(*) as total FROM storefront_reviews WHERE storefront_id = %s AND status = 'approved'",
            (storefront_id,)
        )
        total_count = cursor.fetchone()['total']
        
        # Get reviews
        cursor.execute(f"""
            SELECT id, customer_name, rating, title, comment, product_name, 
                   verified, helpful_count, created_at
            FROM storefront_reviews 
            WHERE storefront_id = %s
            ORDER BY {order_by}
            LIMIT %s OFFSET %s
        """, (storefront_id, limit, offset))
        
        reviews = cursor.fetchall()
        
        # Get rating statistics
        cursor.execute("""
            SELECT 
                AVG(rating) as average_rating,
                COUNT(*) as total_reviews,
                SUM(CASE WHEN rating = 5 THEN 1 ELSE 0 END) as rating_5,
                SUM(CASE WHEN rating = 4 THEN 1 ELSE 0 END) as rating_4,
                SUM(CASE WHEN rating = 3 THEN 1 ELSE 0 END) as rating_3,
                SUM(CASE WHEN rating = 2 THEN 1 ELSE 0 END) as rating_2,
                SUM(CASE WHEN rating = 1 THEN 1 ELSE 0 END) as rating_1
            FROM storefront_reviews 
            WHERE storefront_id = %s AND status = 'approved'
        """, (storefront_id,))
        
        stats = cursor.fetchone()
        
        cursor.close()
        conn.close()
        
        # Format reviews
        formatted_reviews = []
        for review in reviews:
            formatted_reviews.append({
                'id': review['id'],
                'customerName': review['customer_name'],
                'rating': review['rating'],
                'title': review['title'],
                'comment': review['comment'],
                'productName': review['product_name'],
                'verified': review['verified'],
                'helpful': review['helpful_count'],
                'date': review['created_at'].strftime('%Y-%m-%d') if review['created_at'] else None
            })
        
        # Format statistics
        rating_distribution = {
            '5': stats['rating_5'] or 0,
            '4': stats['rating_4'] or 0,
            '3': stats['rating_3'] or 0,
            '2': stats['rating_2'] or 0,
            '1': stats['rating_1'] or 0
        }
        
        return jsonify({
            'reviews': formatted_reviews,
            'pagination': {
                'page': page,
                'limit': limit,
                'total': total_count,
                'pages': (total_count + limit - 1) // limit
            },
            'statistics': {
                'averageRating': round(float(stats['average_rating'] or 0), 1),
                'totalReviews': stats['total_reviews'] or 0,
                'ratingDistribution': rating_distribution
            }
        }), 200
        
    except ValueError:
        return jsonify({"error": "Invalid query parameters"}), 400
    except Exception as e:
        print(f"Error getting reviews: {e}")
        return jsonify({"error": "Internal server error"}), 500

@storefront_reviews_bp.route("/helpful/<review_id>", methods=["POST"])
def mark_helpful(review_id):
    """Mark a review as helpful (increment helpful count)"""
    try:
        conn = get_db_connection()
        cursor = conn.cursor(pymysql.cursors.DictCursor)
        
        # Check if review exists
        cursor.execute(
            "SELECT id, helpful_count FROM storefront_reviews WHERE id = %s AND status = 'approved'",
            (review_id,)
        )
        review = cursor.fetchone()
        
        if not review:
            cursor.close()
            conn.close()
            return jsonify({"error": "Review not found"}), 404
        
        # Increment helpful count
        cursor.execute(
            "UPDATE storefront_reviews SET helpful_count = helpful_count + 1 WHERE id = %s",
            (review_id,)
        )
        
        conn.commit()
        cursor.close()
        conn.close()
        
        return jsonify({
            "message": "Review marked as helpful",
            "helpful_count": review['helpful_count'] + 1
        }), 200
        
    except Exception as e:
        print(f"Error marking review as helpful: {e}")
        return jsonify({"error": "Internal server error"}), 500

@storefront_reviews_bp.route("/admin/pending", methods=["GET"])
def get_pending_reviews():
    """Get all pending reviews for admin moderation (requires authentication)"""
    # Verify admin token (you can implement admin verification here)
    auth_result = verify_token()
    if isinstance(auth_result, tuple):  # Error response
        return auth_result
    
    try:
        conn = get_db_connection()
        cursor = conn.cursor(pymysql.cursors.DictCursor)
        
        cursor.execute("""
            SELECT sr.*, u.username as storefront_name
            FROM storefront_reviews sr
            LEFT JOIN users u ON sr.storefront_id = u.id
            WHERE sr.status = 'pending'
            ORDER BY sr.created_at DESC
        """)
        
        pending_reviews = cursor.fetchall()
        cursor.close()
        conn.close()
        
        # Format reviews
        formatted_reviews = []
        for review in pending_reviews:
            formatted_reviews.append({
                'id': review['id'],
                'storefrontId': review['storefront_id'],
                'storefrontName': review['storefront_name'],
                'customerName': review['customer_name'],
                'email': review['email'],
                'rating': review['rating'],
                'title': review['title'],
                'comment': review['comment'],
                'productName': review['product_name'],
                'createdAt': review['created_at'].strftime('%Y-%m-%d %H:%M:%S') if review['created_at'] else None
            })
        
        return jsonify({
            'pendingReviews': formatted_reviews,
            'total': len(formatted_reviews)
        }), 200
        
    except Exception as e:
        print(f"Error getting pending reviews: {e}")
        return jsonify({"error": "Internal server error"}), 500

@storefront_reviews_bp.route("/admin/moderate/<review_id>", methods=["PUT"])
def moderate_review(review_id):
    """Approve or reject a review (requires authentication)"""
    # Verify admin token
    auth_result = verify_token()
    if isinstance(auth_result, tuple):  # Error response
        return auth_result
    
    try:
        data = request.get_json()
        action = data.get('action')  # 'approve' or 'reject'
        
        if action not in ['approve', 'reject']:
            return jsonify({"error": "Invalid action. Use 'approve' or 'reject'"}), 400
        
        status = 'approved' if action == 'approve' else 'rejected'
        
        conn = get_db_connection()
        cursor = conn.cursor(pymysql.cursors.DictCursor)
        
        # Check if review exists and is pending
        cursor.execute(
            "SELECT id FROM storefront_reviews WHERE id = %s AND status = 'pending'",
            (review_id,)
        )
        review = cursor.fetchone()
        
        if not review:
            cursor.close()
            conn.close()
            return jsonify({"error": "Review not found or already moderated"}), 404
        
        # Update review status
        cursor.execute(
            "UPDATE storefront_reviews SET status = %s, updated_at = %s WHERE id = %s",
            (status, datetime.utcnow(), review_id)
        )
        
        conn.commit()
        cursor.close()
        conn.close()
        
        return jsonify({
            "message": f"Review {action}d successfully",
            "review_id": review_id,
            "status": status
        }), 200
        
    except Exception as e:
        print(f"Error moderating review: {e}")
        return jsonify({"error": "Internal server error"}), 500

@storefront_reviews_bp.route("/stats/<storefront_id>", methods=["GET"])
def get_review_stats(storefront_id):
    """Get review statistics for a storefront"""
    try:
        conn = get_db_connection()
        cursor = conn.cursor(pymysql.cursors.DictCursor)
        
        cursor.execute("""
            SELECT 
                COUNT(*) as total_reviews,
                AVG(rating) as average_rating,
                SUM(CASE WHEN rating = 5 THEN 1 ELSE 0 END) as rating_5,
                SUM(CASE WHEN rating = 4 THEN 1 ELSE 0 END) as rating_4,
                SUM(CASE WHEN rating = 3 THEN 1 ELSE 0 END) as rating_3,
                SUM(CASE WHEN rating = 2 THEN 1 ELSE 0 END) as rating_2,
                SUM(CASE WHEN rating = 1 THEN 1 ELSE 0 END) as rating_1,
                SUM(CASE WHEN verified = 1 THEN 1 ELSE 0 END) as verified_reviews
            FROM storefront_reviews 
            WHERE storefront_id = %s AND status = 'approved'
        """, (storefront_id,))
        
        stats = cursor.fetchone()
        cursor.close()
        conn.close()
        
        return jsonify({
            'totalReviews': stats['total_reviews'] or 0,
            'averageRating': round(float(stats['average_rating'] or 0), 1),
            'verifiedReviews': stats['verified_reviews'] or 0,
            'ratingDistribution': {
                '5': stats['rating_5'] or 0,
                '4': stats['rating_4'] or 0,
                '3': stats['rating_3'] or 0,
                '2': stats['rating_2'] or 0,
                '1': stats['rating_1'] or 0
            }
        }), 200
        
    except Exception as e:
        print(f"Error getting review stats: {e}")
        return jsonify({"error": "Internal server error"}), 500
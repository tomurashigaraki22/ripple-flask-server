from flask import Blueprint, request, jsonify
import pymysql
import uuid
import jwt
import os
from datetime import datetime
from extensions.extensions import get_db_connection
from functions.storefront_notifications import create_notification

storefront_followers_bp = Blueprint("storefront_followers", __name__)

def verify_token():
    """Verify JWT token from request headers"""
    auth_header = request.headers.get("Authorization")

    if not auth_header or not auth_header.startswith("Bearer "):
        return jsonify({"error": "Missing or invalid authorization header"}), 401

    token = auth_header.split(" ")[1]
    print(f"Token: {token}")

    try:
        decoded = jwt.decode(token, os.getenv("JWT_SECRET"), algorithms=["HS256"])
    except jwt.ExpiredSignatureError:
        return jsonify({"error": "Token has expired"}), 401
    except jwt.InvalidTokenError:
        return jsonify({"error": "Invalid token"}), 401

    user_id = decoded.get("userId")
    print(f"Decoded: {decoded}")
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

def create_followers_table():
    """Create the storefront_followers table if it doesn't exist"""
    conn = get_db_connection()
    try:
        cursor = conn.cursor()
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS storefront_followers (
                id VARCHAR(36) PRIMARY KEY,
                follower_id VARCHAR(36) NOT NULL,
                storefront_id VARCHAR(36) NOT NULL,
                storefront_owner_id VARCHAR(36) NOT NULL,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                UNIQUE KEY unique_follow (follower_id, storefront_id),
                INDEX idx_follower (follower_id),
                INDEX idx_storefront (storefront_id),
                INDEX idx_owner (storefront_owner_id),
                FOREIGN KEY (follower_id) REFERENCES users(id) ON DELETE CASCADE,
                FOREIGN KEY (storefront_owner_id) REFERENCES users(id) ON DELETE CASCADE
            )
        """)
        conn.commit()
        print("✅ storefront_followers table created successfully")
    except Exception as e:
        print(f"❌ Error creating storefront_followers table: {e}")
    finally:
        cursor.close()
        conn.close()

# Create table on import
create_followers_table()

def update_follower_count(storefront_id, increment=True):
    """Update the follower count in user_profiles table"""
    conn = get_db_connection()
    try:
        cursor = conn.cursor()
        operation = "+" if increment else "-"
        cursor.execute(f"""
            UPDATE user_profiles 
            SET followers = GREATEST(0, followers {operation} 1),
                updated_at = CURRENT_TIMESTAMP
            WHERE storefront_id = %s
        """, (storefront_id,))
        conn.commit()
    except Exception as e:
        print(f"❌ Error updating follower count: {e}")
    finally:
        cursor.close()
        conn.close()

@storefront_followers_bp.route("/follow", methods=["POST"])
def follow_storefront():
    """Follow a storefront"""
    try:
        # Verify authentication
        auth_result = verify_token()
        if isinstance(auth_result, tuple):
            return auth_result
        
        user = auth_result
        follower_id = user["id"]
        
        data = request.get_json()
        storefront_id = data.get("storefront_id")
        
        if not storefront_id:
            return jsonify({"error": "storefront_id is required"}), 400
        
        conn = get_db_connection()
        cursor = conn.cursor(pymysql.cursors.DictCursor)
        
        # Get storefront owner information
        cursor.execute("""
            SELECT owner_id, name FROM user_profiles 
            WHERE storefront_id = %s
        """, (storefront_id,))
        storefront_info = cursor.fetchone()
        
        if not storefront_info:
            return jsonify({"error": "Storefront not found"}), 404
        
        storefront_owner_id = storefront_info["owner_id"]
        
        # Check if user is trying to follow their own storefront
        if follower_id == storefront_owner_id:
            return jsonify({"error": "Cannot follow your own storefront"}), 400
        
        # Check if already following
        cursor.execute("""
            SELECT id FROM storefront_followers 
            WHERE follower_id = %s AND storefront_id = %s
        """, (follower_id, storefront_id))
        
        if cursor.fetchone():
            return jsonify({"error": "Already following this storefront"}), 400
        
        # Create follow relationship
        follow_id = str(uuid.uuid4())
        cursor.execute("""
            INSERT INTO storefront_followers 
            (id, follower_id, storefront_id, storefront_owner_id) 
            VALUES (%s, %s, %s, %s)
        """, (follow_id, follower_id, storefront_id, storefront_owner_id))
        
        conn.commit()
        
        # Update follower count
        update_follower_count(storefront_id, increment=True)
        
        # Get follower name for notification
        cursor.execute("SELECT username FROM users WHERE id = %s", (follower_id,))
        follower_info = cursor.fetchone()
        follower_name = follower_info["username"] if follower_info else "Unknown User"
        
        # Create notification (using existing notification system)
        try:
            create_notification(
                follower_id, storefront_owner_id, True,
                'New Follower', f'{follower_name} started following your storefront',
                'follow', storefront_id
            )
        except Exception as e:
            print(f"❌ Failed to create follow notification: {e}")
        
        cursor.close()
        conn.close()
        
        return jsonify({
            "success": True,
            "message": "Successfully followed storefront",
            "follow_id": follow_id
        }), 201
        
    except Exception as e:
        print(f"❌ Error following storefront: {e}")
        return jsonify({"error": "Failed to follow storefront"}), 500

@storefront_followers_bp.route("/unfollow", methods=["POST"])
def unfollow_storefront():
    """Unfollow a storefront"""
    try:
        # Verify authentication
        auth_result = verify_token()
        if isinstance(auth_result, tuple):
            return auth_result
        
        user = auth_result
        follower_id = user["id"]
        
        data = request.get_json()
        storefront_id = data.get("storefront_id")
        
        if not storefront_id:
            return jsonify({"error": "storefront_id is required"}), 400
        
        conn = get_db_connection()
        cursor = conn.cursor(pymysql.cursors.DictCursor)
        
        # Check if following
        cursor.execute("""
            SELECT sf.id, sf.storefront_owner_id, up.name as storefront_name
            FROM storefront_followers sf
            JOIN user_profiles up ON sf.storefront_id = up.storefront_id
            WHERE sf.follower_id = %s AND sf.storefront_id = %s
        """, (follower_id, storefront_id))
        
        follow_record = cursor.fetchone()
        if not follow_record:
            return jsonify({"error": "Not following this storefront"}), 400
        
        # Remove follow relationship
        cursor.execute("""
            DELETE FROM storefront_followers 
            WHERE follower_id = %s AND storefront_id = %s
        """, (follower_id, storefront_id))
        
        conn.commit()
        
        # Update follower count
        update_follower_count(storefront_id, increment=False)
        
        # Get follower name for notification
        cursor.execute("SELECT username FROM users WHERE id = %s", (follower_id,))
        follower_info = cursor.fetchone()
        follower_name = follower_info["username"] if follower_info else "Unknown User"
        
        # Create unfollow notification
        try:
            create_notification(
                follower_id, follow_record["storefront_owner_id"], False,
                'Follower Update', f'{follower_name} unfollowed your storefront',
                'unfollow', storefront_id
            )
        except Exception as e:
            print(f"❌ Failed to create unfollow notification: {e}")
        
        cursor.close()
        conn.close()
        
        return jsonify({
            "success": True,
            "message": "Successfully unfollowed storefront"
        }), 200
        
    except Exception as e:
        print(f"❌ Error unfollowing storefront: {e}")
        return jsonify({"error": "Failed to unfollow storefront"}), 500

@storefront_followers_bp.route("/followers/<storefront_id>", methods=["GET"])
def get_storefront_followers(storefront_id):
    """Get list of followers for a storefront"""
    try:
        # Pagination parameters
        limit = int(request.args.get("limit", 20))
        offset = int(request.args.get("offset", 0))
        
        conn = get_db_connection()
        cursor = conn.cursor(pymysql.cursors.DictCursor)
        
        # Get followers with user information
        cursor.execute("""
            SELECT 
                sf.id as follow_id,
                sf.follower_id,
                sf.created_at as followed_at,
                u.username,
                u.email,
                up.name as follower_name,
                up.avatar,
                up.title,
                up.location
            FROM storefront_followers sf
            JOIN users u ON sf.follower_id = u.id
            LEFT JOIN user_profiles up ON u.id = up.owner_id
            WHERE sf.storefront_id = %s
            ORDER BY sf.created_at DESC
            LIMIT %s OFFSET %s
        """, (storefront_id, limit, offset))
        
        followers = cursor.fetchall()
        
        # Get total count
        cursor.execute("""
            SELECT COUNT(*) as total 
            FROM storefront_followers 
            WHERE storefront_id = %s
        """, (storefront_id,))
        
        total_count = cursor.fetchone()["total"]
        
        cursor.close()
        conn.close()
        
        return jsonify({
            "success": True,
            "followers": followers,
            "pagination": {
                "total": total_count,
                "limit": limit,
                "offset": offset,
                "has_more": offset + limit < total_count
            }
        }), 200
        
    except Exception as e:
        print(f"❌ Error getting followers: {e}")
        return jsonify({"error": "Failed to get followers"}), 500

@storefront_followers_bp.route("/following", methods=["GET"])
def get_user_following():
    """Get list of storefronts that the current user is following"""
    try:
        # Verify authentication
        auth_result = verify_token()
        if isinstance(auth_result, tuple):
            return auth_result
        
        user = auth_result
        user_id = user["id"]
        
        # Pagination parameters
        limit = int(request.args.get("limit", 20))
        offset = int(request.args.get("offset", 0))
        
        conn = get_db_connection()
        cursor = conn.cursor(pymysql.cursors.DictCursor)
        
        # Get following storefronts with information
        cursor.execute("""
            SELECT 
                sf.id as follow_id,
                sf.storefront_id,
                sf.created_at as followed_at,
                up.name as storefront_name,
                up.title,
                up.bio,
                up.avatar,
                up.cover_image,
                up.location,
                up.followers,
                up.rating,
                up.total_sales,
                u.username as owner_username
            FROM storefront_followers sf
            JOIN user_profiles up ON sf.storefront_id = up.storefront_id
            JOIN users u ON sf.storefront_owner_id = u.id
            WHERE sf.follower_id = %s
            ORDER BY sf.created_at DESC
            LIMIT %s OFFSET %s
        """, (user_id, limit, offset))
        
        following = cursor.fetchall()
        
        # Get total count
        cursor.execute("""
            SELECT COUNT(*) as total 
            FROM storefront_followers 
            WHERE follower_id = %s
        """, (user_id,))
        
        total_count = cursor.fetchone()["total"]
        
        cursor.close()
        conn.close()
        
        return jsonify({
            "success": True,
            "following": following,
            "pagination": {
                "total": total_count,
                "limit": limit,
                "offset": offset,
                "has_more": offset + limit < total_count
            }
        }), 200
        
    except Exception as e:
        print(f"❌ Error getting following list: {e}")
        return jsonify({"error": "Failed to get following list"}), 500

@storefront_followers_bp.route("/status/<storefront_id>", methods=["GET"])
def get_follow_status(storefront_id):
    """Check if current user is following a specific storefront"""
    try:
        # Verify authentication
        auth_result = verify_token()
        if isinstance(auth_result, tuple):
            return auth_result
        
        user = auth_result
        user_id = user["id"]
        
        conn = get_db_connection()
        cursor = conn.cursor(pymysql.cursors.DictCursor)
        
        # Check follow status
        cursor.execute("""
            SELECT id, created_at 
            FROM storefront_followers 
            WHERE follower_id = %s AND storefront_id = %s
        """, (user_id, storefront_id))
        
        follow_record = cursor.fetchone()
        is_following = follow_record is not None
        
        # Get storefront follower count
        cursor.execute("""
            SELECT followers 
            FROM user_profiles 
            WHERE storefront_id = %s
        """, (storefront_id,))
        
        profile = cursor.fetchone()
        follower_count = profile["followers"] if profile else 0
        
        cursor.close()
        conn.close()
        
        return jsonify({
            "success": True,
            "is_following": is_following,
            "followed_at": follow_record["created_at"] if follow_record else None,
            "follower_count": follower_count
        }), 200
        
    except Exception as e:
        print(f"❌ Error checking follow status: {e}")
        return jsonify({"error": "Failed to check follow status"}), 500

@storefront_followers_bp.route("/stats/<storefront_id>", methods=["GET"])
def get_follower_stats(storefront_id):
    """Get detailed follower statistics for a storefront"""
    try:
        conn = get_db_connection()
        cursor = conn.cursor(pymysql.cursors.DictCursor)
        
        # Get total follower count
        cursor.execute("""
            SELECT COUNT(*) as total_followers 
            FROM storefront_followers 
            WHERE storefront_id = %s
        """, (storefront_id,))
        
        total_followers = cursor.fetchone()["total_followers"]
        
        # Get recent followers (last 30 days)
        cursor.execute("""
            SELECT COUNT(*) as recent_followers 
            FROM storefront_followers 
            WHERE storefront_id = %s 
            AND created_at >= DATE_SUB(NOW(), INTERVAL 30 DAY)
        """, (storefront_id,))
        
        recent_followers = cursor.fetchone()["recent_followers"]
        
        # Get follower growth by month (last 6 months)
        cursor.execute("""
            SELECT 
                DATE_FORMAT(created_at, '%%Y-%%m') as month,
                DATE_FORMAT(created_at, '%%b %%Y') as month_name,
                COUNT(*) as new_followers
            FROM storefront_followers 
            WHERE storefront_id = %s 
            AND created_at >= DATE_SUB(NOW(), INTERVAL 6 MONTH)
            GROUP BY DATE_FORMAT(created_at, '%%Y-%%m')
            ORDER BY month DESC
        """, (storefront_id,))
        
        monthly_growth = cursor.fetchall()
        
        cursor.close()
        conn.close()
        
        return jsonify({
            "success": True,
            "stats": {
                "total_followers": total_followers,
                "recent_followers": recent_followers,
                "monthly_growth": monthly_growth
            }
        }), 200
        
    except Exception as e:
        print(f"❌ Error getting follower stats: {e}")
        return jsonify({"error": "Failed to get follower stats"}), 500
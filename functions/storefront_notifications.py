from flask import Blueprint, request, jsonify
import pymysql
import jwt
import os
from datetime import datetime, timedelta, timezone
import uuid
from uuid import uuid4
import json
from functools import wraps
from extensions.extensions import get_db_connection
from functions.email_helper import send_email

# Blueprint for storefront notifications - ADD template_folder parameter
storefront_notifications_bp = Blueprint('storefront_notifications', __name__, template_folder='../templates')

JWT_SECRET = os.getenv("JWT_SECRET", "your-secret-key")

# Create table if not exists
def create_notifications_table():
    try:
        conn = get_db_connection()
        if conn is None:
            print("❌ Failed to get database connection")
            return
            
        cursor = conn.cursor()
        
        create_table_query = """
        CREATE TABLE IF NOT EXISTS storefront_notifications (
            id INT AUTO_INCREMENT PRIMARY KEY,
            from_user_id VARCHAR(255) NOT NULL,
            to_user_id VARCHAR(255) NOT NULL,
            email BOOLEAN DEFAULT FALSE,
            title VARCHAR(255) NOT NULL,
            description TEXT NOT NULL,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            read_status BOOLEAN DEFAULT FALSE,
            INDEX idx_to_user_id (to_user_id),
            INDEX idx_from_user_id (from_user_id),
            INDEX idx_read_status (read_status),
            INDEX idx_created_at (created_at)
        )
        """
        
        cursor.execute(create_table_query)
        conn.commit()
        cursor.close()
        conn.close()
        print("✅ Storefront notifications table created successfully")
        
    except Exception as e:
        print(f"❌ Error creating notifications table: {e}")

# Initialize table on import
create_notifications_table()

# Helper function to send email notifications using email_helper
def send_email_notification(to_email, title, description, from_user_name=None):
    try:
        print(f"🔍 [EMAIL DEBUG] Starting email send process...")
        print(f"🔍 [EMAIL DEBUG] to_email: {to_email}")
        print(f"🔍 [EMAIL DEBUG] title: {title}")
        print(f"🔍 [EMAIL DEBUG] description: {description}")
        print(f"🔍 [EMAIL DEBUG] from_user_name: {from_user_name}")
        
        # Format timestamp
        timestamp = datetime.now().strftime("%B %d, %Y at %I:%M %p")
        
        # Use email_helper send_email function with **kwargs
        subject = f"🌊 RippleBids: {title}"
        print(f"🔍 [EMAIL DEBUG] Calling send_email with subject: {subject}")
        
        # Pass context as keyword arguments, not as a positional argument
        send_email(
            to_email, 
            subject, 
            'notification_email.html',
            title=title,
            description=description,
            from_user_name=from_user_name,
            timestamp=timestamp
        )
        
        print(f"✅ Email sent successfully to {to_email}")
        return True
        
    except Exception as e:
        print(f"❌ Error sending email notification: {e}")
        print(f"❌ [EMAIL DEBUG] Exception type: {type(e).__name__}")
        print(f"❌ [EMAIL DEBUG] Exception args: {e.args}")
        return False

@storefront_notifications_bp.route("/", methods=["POST"])
def create_notification():
    """
    Creates a new notification
    Expected JSON payload:
    {
        "from_user_id": "string",
        "to_user_id": "string", 
        "email": boolean,
        "title": "string",
        "description": "string"
    }
    """
    try:
        data = request.get_json()
        print(f"🔍 [NOTIFICATION DEBUG] Received data: {data}")
        
        # Validate required parameters
        required_fields = ['from_user_id', 'to_user_id', 'title', 'description']
        for field in required_fields:
            if not data.get(field):
                return jsonify({"error": f"Missing required parameter: {field}"}), 400
        
        from_user_id = data.get('from_user_id')
        to_user_id = data.get('to_user_id')
        email = data.get('email', False)
        title = data.get('title')
        description = data.get('description')
        
        print(f"🔍 [NOTIFICATION DEBUG] Parsed values:")
        print(f"🔍 [NOTIFICATION DEBUG] from_user_id: {from_user_id}")
        print(f"🔍 [NOTIFICATION DEBUG] to_user_id: {to_user_id}")
        print(f"🔍 [NOTIFICATION DEBUG] email: {email}")
        print(f"🔍 [NOTIFICATION DEBUG] title: {title}")
        print(f"🔍 [NOTIFICATION DEBUG] description: {description}")
        
        # Validate email parameter
        if not isinstance(email, bool):
            return jsonify({"error": "Email parameter must be a boolean value"}), 400
        
        conn = get_db_connection()
        if conn is None:
            return jsonify({"error": "Database connection failed"}), 500
            
        cursor = conn.cursor()
        
        # Insert notification
        insert_query = """
        INSERT INTO storefront_notifications 
        (from_user_id, to_user_id, email, title, description, created_at, read_status)
        VALUES (%s, %s, %s, %s, %s, %s, %s)
        """
        
        created_at = datetime.now()
        cursor.execute(insert_query, (
            from_user_id, to_user_id, email, title, description, created_at, False
        ))
        
        notification_id = cursor.lastrowid
        conn.commit()
        print(f"✅ [NOTIFICATION DEBUG] Notification created with ID: {notification_id}")
        
        # Send email if requested
        if email:
            try:
                print(f"🔍 [NOTIFICATION DEBUG] Email requested, looking up user: {to_user_id}")
                
                # Get recipient email - using dictionary access
                user_query = "SELECT email, username FROM users WHERE id = %s"
                print(f"🔍 [NOTIFICATION DEBUG] Executing user query: {user_query} with param: {to_user_id}")
                
                cursor.execute(user_query, (to_user_id,))
                user_data = cursor.fetchone()
                print(f"🔍 [NOTIFICATION DEBUG] User query result: {user_data}")
                print(f"🔍 [NOTIFICATION DEBUG] User data type: {type(user_data)}")
                
                if user_data:
                    print(f"🔍 [NOTIFICATION DEBUG] User found, getting sender info: {from_user_id}")
                    
                    # Get sender name - using dictionary access
                    sender_query = "SELECT username FROM users WHERE id = %s"
                    print(f"🔍 [NOTIFICATION DEBUG] Executing sender query: {sender_query} with param: {from_user_id}")
                    
                    cursor.execute(sender_query, (from_user_id,))
                    sender_data = cursor.fetchone()
                    print(f"🔍 [NOTIFICATION DEBUG] Sender query result: {sender_data}")
                    print(f"🔍 [NOTIFICATION DEBUG] Sender data type: {type(sender_data)}")
                    
                    sender_name = sender_data['username'] if sender_data else None
                    print(f"🔍 [NOTIFICATION DEBUG] Extracted sender_name: {sender_name}")
                    
                    # Send email using email_helper
                    print(f"🔍 [NOTIFICATION DEBUG] Calling send_email_notification...")
                    send_email_notification(
                        user_data['email'],  # dictionary access
                        title, 
                        description, 
                        sender_name
                    )
                else:
                    print(f"⚠️ [NOTIFICATION DEBUG] User {to_user_id} not found for email notification")
            except Exception as email_error:
                print(f"❌ [NOTIFICATION DEBUG] Email sending failed: {str(email_error)}")
                print(f"❌ [NOTIFICATION DEBUG] Email error type: {type(email_error).__name__}")
                print(f"❌ [NOTIFICATION DEBUG] Email error args: {email_error.args}")
                # Don't fail the entire request if email fails
        
        cursor.close()
        conn.close()
        
        return jsonify({
            "id": notification_id,
            "from_user_id": from_user_id,
            "to_user_id": to_user_id,
            "email": email,
            "title": title,
            "description": description,
            "created_at": created_at.isoformat(),
            "read_status": False,
            "success": True
        }), 201
        
    except Exception as e:
        print(f"❌ [NOTIFICATION DEBUG] Error creating notification: {e}")
        print(f"❌ [NOTIFICATION DEBUG] Exception type: {type(e).__name__}")
        print(f"❌ [NOTIFICATION DEBUG] Exception args: {e.args}")
        return jsonify({"error": "Failed to create notification"}), 500

@storefront_notifications_bp.route("/", methods=["GET"])
def get_notifications():
    """
    Gets notifications for a specific user
    Query parameters:
    - user_id: User ID to get notifications for (required)
    - limit: Maximum number of notifications to return (default: 50)
    - unread_only: Only return unread notifications (default: false)
    """
    try:
        user_id = request.args.get('user_id')
        limit = int(request.args.get('limit', 50))
        unread_only = request.args.get('unread_only', 'false').lower() == 'true'
        
        if not user_id:
            return jsonify({"error": "user_id parameter is required"}), 400
        
        conn = get_db_connection()
        if conn is None:
            return jsonify({"error": "Database connection failed"}), 500
            
        cursor = conn.cursor()
        
        # Build query with proper parameter handling
        base_query = """
        SELECT n.*, u.username as from_username
        FROM storefront_notifications n
        LEFT JOIN users u ON n.from_user_id = u.id
        WHERE n.to_user_id = %s
        """
        
        params = [user_id]
        
        if unread_only:
            base_query += " AND n.read_status = FALSE"
        
        base_query += " ORDER BY n.created_at DESC LIMIT %s"
        params.append(limit)  # Pass integer directly, not string
        
        cursor.execute(base_query, params)
        notifications = cursor.fetchall()
        
        cursor.close()
        conn.close()
        
        return jsonify({
            "notifications": notifications,
            "count": len(notifications)
        }), 200
        
    except Exception as e:
        print(f"❌ Error fetching notifications: {e}")
        return jsonify({"error": "Failed to fetch notifications"}), 500

@storefront_notifications_bp.route("/<int:notification_id>/read", methods=["PATCH"])
def mark_notification_as_read(notification_id):
    """
    Marks a notification as read
    """
    try:
        conn = get_db_connection()
        if conn is None:
            return jsonify({"error": "Database connection failed"}), 500
            
        cursor = conn.cursor()
        
        # Check if notification exists
        check_query = "SELECT id FROM storefront_notifications WHERE id = %s"
        cursor.execute(check_query, (notification_id,))
        notification = cursor.fetchone()
        
        if not notification:
            cursor.close()
            conn.close()
            return jsonify({"error": "Notification not found"}), 404
        
        # Update read status
        update_query = "UPDATE storefront_notifications SET read_status = TRUE WHERE id = %s"
        cursor.execute(update_query, (notification_id,))
        conn.commit()
        
        cursor.close()
        conn.close()
        
        return jsonify({
            "message": "Notification marked as read",
            "notification_id": notification_id
        }), 200
        
    except Exception as e:
        print(f"❌ Error marking notification as read: {e}")
        return jsonify({"error": "Failed to mark notification as read"}), 500

@storefront_notifications_bp.route("/<int:notification_id>", methods=["DELETE"])
def delete_notification(notification_id):
    """
    Deletes a notification
    """
    try:
        conn = get_db_connection()
        if conn is None:
            return jsonify({"error": "Database connection failed"}), 500
            
        cursor = conn.cursor()
        
        # Check if notification exists
        check_query = "SELECT id FROM storefront_notifications WHERE id = %s"
        cursor.execute(check_query, (notification_id,))
        notification = cursor.fetchone()
        
        if not notification:
            cursor.close()
            conn.close()
            return jsonify({"error": "Notification not found"}), 404
        
        # Delete notification
        delete_query = "DELETE FROM storefront_notifications WHERE id = %s"
        cursor.execute(delete_query, (notification_id,))
        conn.commit()
        
        cursor.close()
        conn.close()
        
        return jsonify({
            "message": "Notification deleted successfully",
            "notification_id": notification_id
        }), 200
        
    except Exception as e:
        print(f"❌ Error deleting notification: {e}")
        return jsonify({"error": "Failed to delete notification"}), 500

# Specialized notification functions
@storefront_notifications_bp.route("/follow", methods=["POST"])
def create_follow_notification():
    """
    Creates a follow notification
    Expected JSON payload:
    {
        "follower_id": "string",
        "store_owner_id": "string",
        "follower_name": "string"
    }
    """
    try:
        data = request.get_json()
        
        follower_id = data.get('follower_id')
        store_owner_id = data.get('store_owner_id')
        follower_name = data.get('follower_name')
        
        if not all([follower_id, store_owner_id, follower_name]):
            return jsonify({"error": "Missing required parameters"}), 400
        
        conn = get_db_connection()
        if conn is None:
            return jsonify({"error": "Database connection failed"}), 500
            
        cursor = conn.cursor()
        
        insert_query = """
        INSERT INTO storefront_notifications 
        (from_user_id, to_user_id, email, title, description, created_at, read_status)
        VALUES (%s, %s, %s, %s, %s, %s, %s)
        """
        
        created_at = datetime.now()
        cursor.execute(insert_query, (
            follower_id, store_owner_id, True, 
            'New Follower', f'{follower_name} started following your storefront',
            created_at, False
        ))
        
        notification_id = cursor.lastrowid
        conn.commit()
        
        # Send email notification using email_helper
        try:
            user_query = "SELECT email FROM users WHERE id = %s"
            cursor.execute(user_query, (store_owner_id,))
            user_data = cursor.fetchone()
            
            if user_data:
                send_email_notification(
                    user_data['email'],  # dictionary access
                    'New Follower',
                    f'{follower_name} started following your storefront',
                    follower_name
                )
        except Exception as email_error:
            print(f"❌ Email sending failed: {email_error}")
        
        cursor.close()
        conn.close()
        
        return jsonify({
            "id": notification_id,
            "message": "Follow notification created successfully"
        }), 201
        
    except Exception as e:
        print(f"❌ Error creating follow notification: {e}")
        return jsonify({"error": "Failed to create follow notification"}), 500

@storefront_notifications_bp.route("/unfollow", methods=["POST"])
def create_unfollow_notification():
    """
    Creates an unfollow notification
    Expected JSON payload:
    {
        "follower_id": "string",
        "store_owner_id": "string", 
        "follower_name": "string"
    }
    """
    try:
        data = request.get_json()
        
        follower_id = data.get('follower_id')
        store_owner_id = data.get('store_owner_id')
        follower_name = data.get('follower_name')
        
        if not all([follower_id, store_owner_id, follower_name]):
            return jsonify({"error": "Missing required parameters"}), 400
        
        conn = get_db_connection()
        if conn is None:
            return jsonify({"error": "Database connection failed"}), 500
            
        cursor = conn.cursor()
        
        insert_query = """
        INSERT INTO storefront_notifications 
        (from_user_id, to_user_id, email, title, description, created_at, read_status)
        VALUES (%s, %s, %s, %s, %s, %s, %s)
        """
        
        created_at = datetime.now()
        cursor.execute(insert_query, (
            follower_id, store_owner_id, False,
            'Follower Update', f'{follower_name} unfollowed your storefront',
            created_at, False
        ))
        
        notification_id = cursor.lastrowid
        conn.commit()
        
        cursor.close()
        conn.close()
        
        return jsonify({
            "id": notification_id,
            "message": "Unfollow notification created successfully"
        }), 201
        
    except Exception as e:
        print(f"❌ Error creating unfollow notification: {e}")
        return jsonify({"error": "Failed to create unfollow notification"}), 500

# Get notification statistics
@storefront_notifications_bp.route("/stats/<user_id>", methods=["GET"])
def get_notification_stats(user_id):
    """
    Gets notification statistics for a user
    """
    try:
        conn = get_db_connection()
        if conn is None:
            return jsonify({"error": "Database connection failed"}), 500
            
        cursor = conn.cursor()
        
        # Get total and unread counts
        stats_query = """
        SELECT 
            COUNT(*) as total_notifications,
            SUM(CASE WHEN read_status = FALSE THEN 1 ELSE 0 END) as unread_notifications
        FROM storefront_notifications 
        WHERE to_user_id = %s
        """
        
        cursor.execute(stats_query, (user_id,))
        stats = cursor.fetchone()
        
        cursor.close()
        conn.close()
        
        # Handle dictionary access properly
        total_notifications = stats['total_notifications'] if stats else 0
        unread_notifications = stats['unread_notifications'] if stats else 0
        
        return jsonify({
            "total_notifications": total_notifications,
            "unread_notifications": unread_notifications
        }), 200
        
    except Exception as e:
        print(f"❌ Error fetching notification stats: {e}")
        return jsonify({"error": "Failed to fetch notification stats"}), 500
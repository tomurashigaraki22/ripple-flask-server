from flask import Blueprint, request, jsonify
from extensions.extensions import get_db_connection
from middleware.admin_auth import verify_admin_token
from datetime import datetime
import pymysql

admin_dashboard_bp = Blueprint("admin_dashboard", __name__)

def format_time_ago(dt):
    """
    Converts a datetime object to a human-readable "time ago" string.
    
    Example:
        5 seconds ago, 10 minutes ago, 3 hours ago, 2 days ago
    """
    if not dt:
        return ""

    now = datetime.utcnow()
    if isinstance(dt, str):
        # Convert string to datetime if needed
        dt = datetime.fromisoformat(dt)

    diff = now - dt
    seconds = int(diff.total_seconds())

    if seconds < 60:
        return f"{seconds} second{'s' if seconds != 1 else ''} ago"
    elif seconds < 3600:
        minutes = seconds // 60
        return f"{minutes} minute{'s' if minutes != 1 else ''} ago"
    elif seconds < 86400:
        hours = seconds // 3600
        return f"{hours} hour{'s' if hours != 1 else ''} ago"
    else:
        days = seconds // 86400
        return f"{days} day{'s' if days != 1 else ''} ago"

@admin_dashboard_bp.route("/dashboard", methods=["GET", "OPTIONS"])
def get_admin_dashboard():
    if request.method == "OPTIONS":
        return '', 200

    try:
        auth_header = request.headers.get("Authorization", "")
        auth_result = verify_admin_token(auth_header)
        if not auth_result.get("success"):
            return jsonify({"error": auth_result.get("error")}), auth_result.get("status", 401)

        conn = get_db_connection()
        try:
            with conn.cursor(pymysql.cursors.DictCursor) as cur:
                # Total users
                cur.execute('SELECT COUNT(*) AS total FROM users WHERE status="active"')
                total_users = cur.fetchone()['total']

                # Total listings
                cur.execute('SELECT COUNT(*) AS total FROM listings')
                total_listings = cur.fetchone()['total']

                # Pending listings
                cur.execute('SELECT COUNT(*) AS total FROM listings WHERE status="pending"')
                pending_listings = cur.fetchone()['total']

                # Total orders
                cur.execute('SELECT COUNT(*) AS total FROM orders')
                total_orders = cur.fetchone()['total']

                # Total revenue from completed orders
                cur.execute('SELECT COALESCE(SUM(amount),0) AS total FROM orders WHERE status="completed"')
                total_revenue = float(cur.fetchone()['total'] or 0)

                # Active memberships
                cur.execute('''SELECT COUNT(*) AS total FROM user_memberships 
                               WHERE is_active=TRUE AND (expires_at IS NULL OR expires_at > NOW())''')
                active_memberships = cur.fetchone()['total']

                # Recent users
                cur.execute('SELECT username, created_at FROM users ORDER BY created_at DESC LIMIT 3')
                recent_users = cur.fetchall()

                # Recent listings
                cur.execute('''SELECT l.title, l.created_at, u.username 
                               FROM listings l JOIN users u ON l.user_id = u.id 
                               ORDER BY l.created_at DESC LIMIT 3''')
                recent_listings = cur.fetchall()

                # Recent orders
                cur.execute('''SELECT o.id, o.created_at, o.amount, u.username as buyer_name
                               FROM orders o JOIN users u ON o.buyer_id = u.id
                               ORDER BY o.created_at DESC LIMIT 3''')
                recent_orders = cur.fetchall()

            # Build recent activity list
            recent_activity = []

            for user in recent_users:
                recent_activity.append({
                    "type": "user",
                    "description": f"New user {user['username']} joined",
                    "timestamp": format_time_ago(user['created_at']),
                    "time": user['created_at']
                })

            for listing in recent_listings:
                recent_activity.append({
                    "type": "listing",
                    "description": f"{listing['username']} created listing \"{listing['title']}\"",
                    "timestamp": format_time_ago(listing['created_at']),
                    "time": listing['created_at']
                })

            for order in recent_orders:
                recent_activity.append({
                    "type": "order",
                    "description": f"{order['buyer_name']} placed order #{order['id']} (${float(order['amount']):.2f})",
                    "timestamp": format_time_ago(order['created_at']),
                    "time": order['created_at']
                })

            # Sort by raw timestamp descending
            recent_activity.sort(key=lambda x: x["time"], reverse=True)

            # Limit to 10 items and remove raw time
            limited_activity = recent_activity[:10]
            for activity in limited_activity:
                del activity["time"]

            stats = {
                "totalUsers": total_users,
                "totalListings": total_listings,
                "totalOrders": total_orders,
                "totalRevenue": total_revenue,
                "pendingListings": pending_listings,
                "activeMemberships": active_memberships
            }

            return jsonify({"stats": stats, "recentActivity": limited_activity})

        finally:
            conn.close()

    except Exception as e:
        print("Error fetching admin dashboard data:", str(e))
        return jsonify({"error": "Internal server error"}), 500



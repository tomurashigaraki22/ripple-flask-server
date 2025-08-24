from flask import Blueprint, request, jsonify
import pymysql
import jwt
from datetime import datetime, timedelta
from extensions.extensions import get_db_connection
from functions.storefront import verify_storefront_access_func
import os

JWT_SECRET = os.environ.get("JWT_SECRET", "your-secret-key")

storefront_analytics_bp = Blueprint("storefront_analytics", __name__)

def get_date_range(range_str):
    now = datetime.utcnow()
    start_date = now

    if range_str == "7d":
        start_date = now - timedelta(days=7)
    elif range_str == "30d":
        start_date = now - timedelta(days=30)
    elif range_str == "90d":
        start_date = now - timedelta(days=90)
    elif range_str == "1y":
        start_date = now.replace(year=now.year - 1)
    else:
        start_date = now - timedelta(days=30)

    return start_date.date(), now.date()


@storefront_analytics_bp.route("/metrics", methods=["GET"])
def get_analytics():
    # Verify user
    user_or_response = verify_storefront_access_func()
    if isinstance(user_or_response, tuple):  # failed verification
        return user_or_response

    user = user_or_response
    user_id = user["id"]

    range_str = request.args.get("range", "30d")
    start_date, end_date = get_date_range(range_str)

    try:
        conn = get_db_connection()
        cursor = conn.cursor(pymysql.cursors.DictCursor)
        cursor.execute("SET SESSION sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));")


        # Total views
        cursor.execute("SELECT COALESCE(SUM(views),0) as total FROM listings WHERE user_id=%s", (user_id,))
        total_views = cursor.fetchone()["total"]

        # Total earnings
        cursor.execute("""
            SELECT COALESCE(SUM(o.amount),0) as total
            FROM orders o
            JOIN listings l ON o.listing_id = l.id
            WHERE l.user_id=%s AND o.status IN ('delivered','completed')
            AND DATE(o.created_at) BETWEEN %s AND %s
        """, (user_id, start_date, end_date))
        total_earnings = float(cursor.fetchone()["total"] or 0)

        # Active listings
        cursor.execute("SELECT COUNT(*) as count FROM listings WHERE user_id=%s AND status='approved'", (user_id,))
        total_listings = cursor.fetchone()["count"]

        # Conversion rate
        cursor.execute("""
            SELECT COUNT(*) as count
            FROM orders o
            JOIN listings l ON o.listing_id = l.id
            WHERE l.user_id=%s AND DATE(o.created_at) BETWEEN %s AND %s
        """, (user_id, start_date, end_date))
        orders_count = cursor.fetchone()["count"]
        conversion_rate = (orders_count / total_views * 100) if total_views > 0 else 0

        # Monthly performance
        cursor.execute("""
            SELECT 
                DATE_FORMAT(o.created_at, '%%Y-%%m') as month,
                DATE_FORMAT(o.created_at, '%%b') as month_name,
                COALESCE(SUM(o.amount),0) as earnings,
                COUNT(*) as orders
            FROM orders o
            JOIN listings l ON o.listing_id = l.id
            WHERE l.user_id=%s AND o.status IN ('delivered','completed')
            AND DATE(o.created_at) BETWEEN %s AND %s
            GROUP BY DATE_FORMAT(o.created_at, '%%Y-%%m')
            ORDER BY month ASC
            LIMIT 12
        """, (user_id, start_date, end_date))
        monthly_data = [
            {"month": row["month_name"], "earnings": float(row["earnings"] or 0), "orders": row["orders"]}
            for row in cursor.fetchall()
        ]

        # Top listings
        cursor.execute("""
            SELECT 
                l.id,
                l.title,
                l.views,
                COALESCE(SUM(o.amount),0) as earnings,
                COUNT(o.id) as orders
            FROM listings l
            LEFT JOIN orders o ON l.id=o.listing_id 
                AND o.status IN ('delivered','completed')
                AND DATE(o.created_at) BETWEEN %s AND %s
            WHERE l.user_id=%s AND l.status='approved'
            GROUP BY l.id, l.title, l.views
            ORDER BY earnings DESC, l.views DESC
            LIMIT 5
        """, (start_date, end_date, user_id))
        top_listings = [
            {"id": row["id"], "title": row["title"], "views": row["views"], "earnings": float(row["earnings"] or 0), "orders": row["orders"]}
            for row in cursor.fetchall()
        ]

        # Category performance
        cursor.execute("""
            SELECT 
                l.category,
                COUNT(DISTINCT l.id) as listings,
                COALESCE(SUM(l.views),0) as views,
                COALESCE(SUM(o.amount),0) as earnings
            FROM listings l
            LEFT JOIN orders o ON l.id=o.listing_id 
                AND o.status IN ('delivered','completed')
                AND DATE(o.created_at) BETWEEN %s AND %s
            WHERE l.user_id=%s AND l.status='approved'
            GROUP BY l.category
            ORDER BY earnings DESC
        """, (start_date, end_date, user_id))
        category_performance = [
            {"name": row["category"] or "uncategorized", "listings": row["listings"], "views": row["views"], "earnings": float(row["earnings"] or 0)}
            for row in cursor.fetchall()
        ]

        cursor.close()
        conn.close()

        return jsonify({
            "success": True,
            "analytics": {
                "overview": {
                    "totalViews": total_views,
                    "totalEarnings": total_earnings,
                    "totalListings": total_listings,
                    "conversionRate": conversion_rate
                },
                "monthlyData": monthly_data,
                "topListings": top_listings,
                "categoryPerformance": category_performance
            },
            "timeRange": range_str
        })

    except Exception as e:
        print(f"Error fetching analytics: {e}")
        return jsonify({"error": "Internal server error"}), 500

from flask import Flask
from flask_cors import CORS
import pymysql
import os
from dotenv import load_dotenv
from flask_mail import Mail, Message

# Load environment variables from .env file
load_dotenv()

app = Flask(__name__)

# ✅ Allow all origins for CORS
CORS(app, resources={r"/*": {"origins": "*"}})

# ✅ Database connection
def get_db_connection():
    try:
        connection = pymysql.connect(
            host=os.getenv("DB_HOST", "localhost"),
            user=os.getenv("DB_USER", "root"),
            password=os.getenv("DB_PASSWORD", ""),
            database=os.getenv("DB_NAME", "ripplebids"),
            port=int(os.getenv("DB_PORT", 3306)),
            cursorclass=pymysql.cursors.DictCursor
        )
        return connection
    except Exception as e:
        print(f"❌ Database connection failed: {e}")
        return None

# ✅ Flask-Mail configuration
app.config['MAIL_SERVER'] = os.getenv("SMTP_HOST")
app.config['MAIL_PORT'] = int(os.getenv("SMTP_PORT", 587))
app.config['MAIL_USE_TLS'] = os.getenv("SMTP_SECURE", "false").lower() != "true"
app.config['MAIL_USE_SSL'] = os.getenv("SMTP_SECURE", "false").lower() == "true"
app.config['MAIL_USERNAME'] = os.getenv("SMTP_USER")
app.config['MAIL_PASSWORD'] = os.getenv("SMTP_PASSWORD")
app.config['MAIL_DEFAULT_SENDER'] = ("RippleBids", os.getenv("SMTP_FROM", os.getenv("SMTP_USER")))

# Initialize Flask-Mail
mail = Mail(app)

# ✅ Example usage
def send_test_email(to_email, subject="Test Email", body="This is a test email"):
    try:
        msg = Message(subject=subject, recipients=[to_email], body=body)
        mail.send(msg)
        print(f"✅ Email sent to {to_email}")
    except Exception as e:
        print(f"❌ Failed to send email: {e}")

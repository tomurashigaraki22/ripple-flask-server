from flask import render_template
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
import os

# Use environment variables for security
SMTP_USER = os.getenv("SMTP_USER", "devtomiwa9@gmail.com")
SMTP_PASSWORD = os.getenv("SMTP_PASSWORD", "skyh iwhz zzis exdq")
SMTP_FROM = os.getenv("SMTP_FROM", "RippleBids")
SMTP_HOST = os.getenv("SMTP_HOST", "smtp.gmail.com")
SMTP_PORT = int(os.getenv("SMTP_PORT", 465))  # Changed from 587 to 465

def send_email(to, subject, template, context):
    """
    Send an email with Flask template
    """
    try:
        print(f"🔍 [EMAIL_HELPER DEBUG] Starting send_email function...")
        print(f"🔍 [EMAIL_HELPER DEBUG] to: {to}")
        print(f"🔍 [EMAIL_HELPER DEBUG] subject: {subject}")
        print(f"🔍 [EMAIL_HELPER DEBUG] template: {template}")
        print(f"🔍 [EMAIL_HELPER DEBUG] context: {context}")
        print(f"🔍 [EMAIL_HELPER DEBUG] SMTP settings - Host: {SMTP_HOST}, Port: {SMTP_PORT}, User: {SMTP_USER}")
        
        # Render HTML content from template
        print(f"🔍 [EMAIL_HELPER DEBUG] Rendering template...")
        html_content = render_template(template, **context)
        print(f"🔍 [EMAIL_HELPER DEBUG] Template rendered successfully, length: {len(html_content)}")
        print(f"🔍 [EMAIL_HELPER DEBUG] HTML preview (first 200 chars): {html_content[:200]}...")

        # Construct email
        print(f"🔍 [EMAIL_HELPER DEBUG] Constructing email message...")
        msg = MIMEMultipart("alternative")
        msg["Subject"] = subject
        msg["From"] = f"{SMTP_FROM} <{SMTP_USER}>"
        msg["To"] = to
        part = MIMEText(html_content, "html")
        msg.attach(part)
        print(f"🔍 [EMAIL_HELPER DEBUG] Email message constructed")

        # Connect to Gmail SMTP server using SSL (port 465)
        print(f"🔍 [EMAIL_HELPER DEBUG] Connecting to SMTP server using SSL...")
        with smtplib.SMTP_SSL(SMTP_HOST, SMTP_PORT) as server:  # Use SMTP_SSL for port 465
            print(f"🔍 [EMAIL_HELPER DEBUG] SSL SMTP connection established")
            print(f"🔍 [EMAIL_HELPER DEBUG] Logging in...")
            server.login(SMTP_USER, SMTP_PASSWORD)
            print(f"🔍 [EMAIL_HELPER DEBUG] Login successful")
            print(f"🔍 [EMAIL_HELPER DEBUG] Sending email...")
            server.sendmail(SMTP_USER, to, msg.as_string())
            print(f"🔍 [EMAIL_HELPER DEBUG] Email sent successfully")

        print(f"✅ Email sent to {to} ({subject})")
    except Exception as e:
        print(f"❌ [EMAIL_HELPER DEBUG] Error sending email: {e}")
        print(f"❌ [EMAIL_HELPER DEBUG] Exception type: {type(e).__name__}")
        print(f"❌ [EMAIL_HELPER DEBUG] Exception args: {e.args}")
        raise e  # Re-raise to let caller handle

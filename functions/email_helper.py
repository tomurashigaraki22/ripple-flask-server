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
SMTP_PORT = int(os.getenv("SMTP_PORT", 587))

def send_email(to_email, subject, template_name, **template_vars):
    try:
        print(f"🔍 [EMAIL_HELPER DEBUG] Starting send_email function...")
        print(f"🔍 [EMAIL_HELPER DEBUG] to: {to_email}")
        print(f"🔍 [EMAIL_HELPER DEBUG] subject: {subject}")
        print(f"🔍 [EMAIL_HELPER DEBUG] template: {template_name}")
        print(f"🔍 [EMAIL_HELPER DEBUG] context: {template_vars}")
        print(f"🔍 [EMAIL_HELPER DEBUG] SMTP settings - Host: {SMTP_HOST}, Port: {SMTP_PORT}, User: {SMTP_USER}")
        
        # Render the email template
        print(f"🔍 [EMAIL_HELPER DEBUG] Rendering template...")
        html_content = render_template(template_name, **template_vars)
        print(f"🔍 [EMAIL_HELPER DEBUG] Template rendered successfully, length: {len(html_content)}")
        print(f"🔍 [EMAIL_HELPER DEBUG] HTML preview (first 200 chars): {html_content[:200]}...")
        
        # Create message
        print(f"🔍 [EMAIL_HELPER DEBUG] Constructing email message...")
        msg = MIMEMultipart('alternative')
        msg['Subject'] = subject
        msg['From'] = f"{SMTP_FROM} <{SMTP_USER}>"
        msg['To'] = to_email
        
        # Add HTML content
        html_part = MIMEText(html_content, 'html')
        msg.attach(html_part)
        print(f"🔍 [EMAIL_HELPER DEBUG] Email message constructed")
        
        print(f"🔍 [EMAIL_HELPER DEBUG] Connecting to SMTP server...")
        
        # Choose the correct SMTP method based on port
        if SMTP_PORT == 465:
            # Port 465 uses SSL from the start
            server = smtplib.SMTP_SSL(SMTP_HOST, SMTP_PORT)
            print(f"🔍 [EMAIL_HELPER DEBUG] Using SMTP_SSL for port 465")
        else:
            # Port 587 uses STARTTLS
            server = smtplib.SMTP(SMTP_HOST, SMTP_PORT)
            server.starttls()  # Enable encryption
            print(f"🔍 [EMAIL_HELPER DEBUG] Using SMTP with STARTTLS for port 587")
        
        print(f"🔍 [EMAIL_HELPER DEBUG] Logging in with user: {SMTP_USER}")
        server.login(SMTP_USER, SMTP_PASSWORD)
        
        print(f"🔍 [EMAIL_HELPER DEBUG] Sending email...")
        server.send_message(msg)
        server.quit()
        
        print(f"✅ [EMAIL_HELPER DEBUG] Email sent successfully to {to_email}")
        return True
        
    except Exception as e:
        print(f"❌ [EMAIL_HELPER DEBUG] Error sending email: {str(e)}")
        print(f"❌ [EMAIL_HELPER DEBUG] Exception type: {type(e).__name__}")
        print(f"❌ [EMAIL_HELPER DEBUG] Exception args: {e.args}")
        return False

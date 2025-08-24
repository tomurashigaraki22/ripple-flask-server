from flask import render_template
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
import os

# Use environment variables for security
SMTP_USER = os.getenv("SMTP_USER", "noreply.dropapp@gmail.com")
SMTP_PASSWORD = os.getenv("SMTP_PASSWORD", "iaik logl kifo tzzw")
SMTP_FROM = os.getenv("SMTP_FROM", "RippleBids")
SMTP_HOST = os.getenv("SMTP_HOST", "smtp.gmail.com")
SMTP_PORT = int(os.getenv("SMTP_PORT", 587))


def send_email(to, subject, template, context):
    """
    Send an email with Flask template
    """
    try:
        # Render HTML content from template
        html_content = render_template(template, **context)

        # Construct email
        msg = MIMEMultipart("alternative")
        msg["Subject"] = subject
        msg["From"] = f"{SMTP_FROM} <{SMTP_USER}>"
        msg["To"] = to
        part = MIMEText(html_content, "html")
        msg.attach(part)

        # Connect to Gmail SMTP server
        with smtplib.SMTP(SMTP_HOST, SMTP_PORT) as server:
            server.starttls()  # Secure connection
            server.login(SMTP_USER, SMTP_PASSWORD)
            server.sendmail(SMTP_USER, to, msg.as_string())

        print(f"Email sent to {to} ({subject})")
    except Exception as e:
        print("Error sending email:", e)

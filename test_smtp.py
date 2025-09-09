import smtplib
from email.mime.text import MIMEText

try:
    server = smtplib.SMTP_SSL('smtp.gmail.com', 465)
    server.login('devtomiwa9@gmail.com', 'skyh iwhz zzis exdq')
    
    msg = MIMEText('Test email')
    msg['Subject'] = 'SMTP Test'
    msg['From'] = 'devtomiwa9@gmail.com'
    msg['To'] = 'devtomiwa9@gmail.com'
    
    server.send_message(msg)
    server.quit()
    print("✅ Email sent successfully!")
except Exception as e:
    print(f"❌ Error: {e}")
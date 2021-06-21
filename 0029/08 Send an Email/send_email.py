import smtplib

SENDER_EMAIL = 'YOUR_EMAIL@EMAIL.COM' # replace with your email address
SENDER_PASSWORD = 'YOUR_PASSWORD'     # replace with your email password

def send_email(receiver_email, subject, body):
    message = 'Subject: {}\n\n{}'.format(subject, body)
    with smtplib.SMTP_SSL('smtp.gmail.com', 465) as server:
        server.login(SENDER_EMAIL, SENDER_PASSWORD)
        server.sendmail(SENDER_EMAIL, receiver_email, message)

if __name__ == '__main__':
    # replace receiver email address
    send_email('RECEIVER@EMAIL.COM', 'Notification', 'Everything is awesome!')
import smtplib
import os
import sys
from email.mime.text import MIMEText


def sendNotificationEmail(receiver,subject,content):
    gmail_user = 'robot60742@gmail.com'
    gmail_pwd = 'sss60742'
    smtpserver = smtplib.SMTP("smtp.gmail.com",587)
    smtpserver.ehlo()
    smtpserver.starttls()
    smtpserver.ehlo
    smtpserver.login(gmail_user, gmail_pwd)

    msg = MIMEText(content,'html','utf-8')
    msg['Subject'] = subject
    msg['From'] = gmail_user
    msg['To'] = receiver

    #header = 'To:' + to + '\n' + 'From: ' + gmail_user + '\n' + 'Subject:' + subject + ' \n'
    #print header
    #msg = header + content
    smtpserver.sendmail(gmail_user, receiver, msg.as_string())
    #print 'done!'
    smtpserver.close()


if __name__ == "__main__":
    print 'testing ' + os.path.realpath(sys.argv[0])
    to = 'sibinlu60742@163.com'
    content = '<html><h1>Python Robot</h1></html>'
    subject = 'smtplib testing'
    sendNotificationEmail(to,subject,content)

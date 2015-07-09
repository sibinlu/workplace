import smtplib
from email.mime.text import MIMEText

def sendEmail(receiver,subject,content):
  #sender = 'robot60742@163.com'
  smtpserver = 'smtp.163.com'
  username = 'sibinlu60742@163.com'
  password = '16360742'
  
  msg = MIMEText(content,'html','utf-8')
  msg['Subject'] = subject
  msg['From'] = username
  msg['To'] = receiver

  smtp = smtplib.SMTP_SSL('smtp.163.com',994)
  smtp.login(username,password)
  smtp.sendmail(username,receiver,msg.as_string())
  #smtp.quit()

#c = '<html><h1>hihi</h1></html>'
#s = 'python email test'
#r = 'sibinlu60742@163.com'

#sendEmail(r,s,c)


#e ='sibinlu60742@126.com'
#m = MIMEText('body')
#m['subject'] = 'test'
#m['from'] = e
#m['to'] = e
#s = smtplib.SMTP_SSL('smtp.126.com',994)
#s.login(e,'12660742')
#s.sendmail(e,e,m.as_string())

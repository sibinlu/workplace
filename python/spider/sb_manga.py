import sb_mangaspider
import sb_email
import time
from threading import Timer  
  
def checkmanga():
  t = time.strftime('%Y-%m-%d %H:%M:%S',time.localtime(time.time()))
  t2 = time.strftime('[%Y-%m-%d]',time.localtime(time.time()))
  
  print t
  
  l = sb_mangaspider.checkall()
  #sb_mangaspider.printUpdate(l)
  
  title = t2 + 'Manga Update!'
  m = '<h1>Manga Update!!</h1></br>'
  haveupdate = 0
  
  for manga in l:
    if manga[0] == '1':
      print 'Update:\nTitle:%s\nLink:%s\n' % (manga[1],manga[2]) 
      s = ' title:%s </br> link:<a href=\'%s\'>%s</a> </br>' % (manga[1],manga[2],manga[2])
      m += s + '</br>'
      haveupdate = 1
  
  
  if haveupdate == 1:
    print 'Email for updates'
    sb_email.sendEmail('sibinlu60742@163.com',title,m)
  else:
    print "No Update"
  
  
  print '----------------------------------------------------------------------'


def schedulecheck():
  #print time.strftime('%Y-%m-%d %H:%M:%S',time.localtime(time.time()))
  checkmanga() 
  t = Timer(1*60*60,schedulecheck)
  t.start()

schedulecheck()

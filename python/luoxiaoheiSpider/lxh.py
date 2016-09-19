#!/usr/bin/python
# -*- coding: UTF-8 -*-
import os
import sys
import bs4
import sb_email
import lxhspider


if __name__ == "__main__":

  print 'testing ' + os.path.realpath(sys.argv[0])
  subject = '罗小黑更新了你敢信'
  to = 'sibinlu60742@163.com'
  to2 = 'cat.kawai.ng@gmail.com'
  cachefile = 'cache.txt'
  
  print 'Fetching data...'

  result = lxhspider.getlatest()
  title = result[0]
  link = result[1]

  mode = 'r+'
  if os.path.isfile(cachefile) == 0:
    mode = 'w+'
  
  f = open(cachefile,mode)
  cache = f.read().decode('utf8')
  if cache != title:
    soup = bs4.BeautifulSoup('<h2>罗小黑更新了你敢信</h2><a href="" id="title"></a>')  
    soup.a['href'] = link
    soup.a.append(title)
    content = soup.prettify()
    sb_email.sendNotificationEmail(to,subject,content)
    sb_email.sendNotificationEmail(to2,subject,content)

    f.seek(0,0)
    f.truncate()
    f.write(title.encode('utf8'))
    print 'Series update and send email'
  else:
    print 'No update'
    
  f.close() 

    
    #print(soup.prettify())

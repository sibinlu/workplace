import requests
import bs4
import os

manga_list = [['http://www.ishuhui.com/archives/category/zaixianmanhua/op','op','ish'],
              ['http://www.ishuhui.com/archives/category/zaixianmanhua/ft','ft','ish'],
              ['http://www.ishuhui.com/archives/category/zaixianmanhua/aot','aot','ish'],
              ['http://www.ishuhui.com/archives/category/zaixianmanhua/gintama','gt','ish'],
              ['http://manhua.dmzj.com/kenan','kn','dmzj'],
              ['http://manhua.dmzj.com/jintianyi2010','jty','dmzj']
             ]

onlyshowupdate = 1

def getsoup(url):
  #print 'Start to check updates'
  try:
    response = requests.get(url)
  except requests.exceptions.ConnectionError:
    print 'Connection Error'
    return None
  html = response.text
  soup = bs4.BeautifulSoup(html)
  return soup

## return a list [isUpdate, Title, Link]
def checkish(soup,file):
  result = soup.select('div.caption a ')[0]
  link = result.attrs.get('href') 
  title = result.attrs.get('title')
  isUpdate ='0';  
  mode = 'r+'
  if os.path.isfile(file) == 0:
    mode = 'w+'
  f = open(file,mode)
  cache = f.read().decode('gbk')
  if cache != title:
    isUpdate = '1'
    f.seek(0,0)
    f.truncate()
    f.write(title.encode('gbk'))
  else:
    isUpdate = '0'
  f.close() 
  return [isUpdate,title,link]

## return a list [isUpdate, Title, Link]
def checkdmzj(soup,file):
  rl = soup.select('div.odd_anim_title_m a')
  link = 'http://manhua.dmzj.com' + rl[1].attrs.get('href') 
  title = rl[0].getText() + ' ' + rl[1].getText()
  isUpdate ='0';  
  mode = 'r+'
  if os.path.isfile(file) == 0:
    mode = 'w+'
  f = open(file,mode)
  cache = f.read().decode('gbk')
  if cache != title:
    isUpdate = '1'
    f.seek(0,0)
    f.truncate()
    f.write(title.encode('gbk'))
  else:
    isUpdate = '0'
  f.close() 
  return [isUpdate,title,link]


## return a list of objects for [isUpdate, Title, Link]
def checkall():
  list=[]
  for manga in manga_list:
    url = manga[0]
    file = manga[1]
    type = manga[2]
    soup = getsoup(url)
    if soup is None:
      return list
    
    if type == 'ish':
      result = checkish(soup,file)
      list.append(result)

    if type == 'dmzj':
      result = checkdmzj(soup,file)
      list.append(result)
  return list


def printUpdate(list):
  for result in list:
    print result[0] + '\t' + result[1] + '\t' + result[2]

#l = checkall()
#printUpdate(l)


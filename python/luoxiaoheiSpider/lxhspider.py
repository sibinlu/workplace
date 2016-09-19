#!/usr/bin/python
# -*- coding: UTF-8 -*-

import sys
import os 
import requests
import bs4

lxhurl = 'https://www.youtube.com/playlist?list=PLgQCLQlBS8NyR8btX2TR3dxLVaahh4HI3'

def getsoup(url):
  try:
    response = requests.get(url)
  except requests.exceptions.ConnectionError:
    print 'connection error'
    return None
  html = response.text
  soup =  bs4.BeautifulSoup(html)
  return soup

def getlatest():
    
    soup = getsoup(lxhurl)

    #table = soup.find_all(id='pl-load-more-destination')[0]
    line = soup.find_all("tr", attrs={"class": "pl-video yt-uix-tile "})[0]
    #print line
    link = line.find_all("a",attrs={"class": "pl-video-title-link yt-uix-tile-link yt-uix-sessionlink spf-link "})[0]
    list = [link.getText().strip() , 'https://www.youtube.com' + link.get('href')]
    return list

if __name__ == '__main__':
  print 'testing '+ __file__
  list = check()
  print list[0]
  print list[1]

  

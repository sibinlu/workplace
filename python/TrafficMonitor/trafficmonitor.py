#!/usr/bin/python
# -*- coding: UTF-8 -*-
#LastUpdate: Nov 10 2016


WantedTime = 34
PlayMusic = 0

import math
import gmspider as gs
import datetime
import time
import os


def cheer(m):
    if PlayMusic:
        os.system('afplay miao.m4a')
    else:
        dialog="if [ -n \"`which osascript`\" ]; then osascript -e 'display dialog \"Welcom Home Meow! ("+str(m) + " min"+ ")\"';  else echo 'osacript not found'; fi"
        os.system(dialog)
        #print "\a\a\a"

def check(time):
    threshold = WantedTime * 60
    m = int(math.ceil( time/60.0))

    if time < threshold:
        print "Time to back home"
        print str(m) + " min"
        cheer(m) 
        return 1
    else:
        print "Let's wait..." + str(m) + " min"
        return 0

def checkloop():
    while 1:
        print datetime.datetime.now().strftime("%I:%M%p") +"  #  Start Check "
        t = gs.gettime()
        r=check(t)
        if r:
            break
        time.sleep(120)


if __name__ == '__main__':
    checkloop()
    


#!/usr/bin/python
# -*- coding: UTF-8 -*-

WantedTime = 20
PlayMusic = 1

import math
import gmspider as gs
import datetime
import time
import os

def check(time):
    threshold = WantedTime * 60
    m = int(math.ceil( time/60.0))

    if time < threshold:
        print "Time to back home"
        print str(m) + " min"
        if PlayMusic:
            os.system('afplay miao.m4a')
        else:
            print "\a\a\a"
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
    


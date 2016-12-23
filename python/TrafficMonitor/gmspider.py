#!/usr/bin/python
# -*- coding: UTF-8 -*-

import sys
import os
import requests
import numpy
import re
import math

gmurl = 'https://www.google.com/maps/dir/1+Hacker+Way,+Menlo+Park,+CA/4650+Cambio+Court,+Fremont,+CA+94536-5553,+USA/@37.4979346,-122.1557879,13z/data=!4m13!4m12!1m5!1m1!1s0x808fbc971ab4450d:0xe6832c3ece523d0e!2m2!1d-122.1478657!2d37.4846233!1m5!1m1!1s0x808fbfa46f982345:0xffa4d41703f465ea!2m2!1d-122.02208!2d37.55567'


def gethtml():
    try:
        response = requests.get(gmurl)
    except requests.exceptions.ConnectionError:
        print 'connection error'
        return None
    html = response.text
    return html


def gettime():
    html = gethtml()
    match = re.search(r'\["CA-84 E",\[[^\]]*\],\[[^\[]*\[\[([0-9]*)', html)
    time = match.group(1)
    return float(time)


if __name__ == '__main__':
    print 'testing ' + __file__
    t = gettime()
    print t
    m = int(math.ceil(t / 60.0))
    print str(m) + " min"

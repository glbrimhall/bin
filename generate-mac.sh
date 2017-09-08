#!/usr/bin/env python
#  -*- mode: python; -*-

#print ""
#print "New UUID:"
#import virtinst.util ; print virtinst.util.uuidToString(virtinst.util.randomUUID())
#print "New MAC:"
#import virtinst.util ; print virtinst.util.randomMAC()
#prin#t ""


import random
#
def randomMAC():
    mac = [ 0x00, 0x16, 0x3e,
            random.randint(0x00, 0x7f),
            random.randint(0x00, 0xff),
            random.randint(0x00, 0xff) ]
    return ':'.join(map(lambda x: "%02x" % x, mac))
#
print randomMAC()

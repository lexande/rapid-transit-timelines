#!/usr/bin/env python

import mechanize
import sys
import re

br = mechanize.Browser()
br.set_handle_robots(False)
br.set_handle_refresh(False)
br.addheaders = [('User-agent', 'Lynx/2.8.7pre.5 libwww-FM/2.14 SSL-MM/1.4.1')]
br.open("http://isotp.metro.net/MetroRidership/IndexAllBus.aspx")
for x in [ 2, 4, 9, 10, 14, 16, 18, 20, 26, 28, 30, 33, 35, 38, 40, 42, 45, 51, 53, 55, 60, 62, 66, 70, 71, 76, 78, 81, 83, 84, 90, 92, 94, 96, 102, 105, 108, 110, 111, 115, 117, 120, 121, 124, 125, 126, 127, 128, 130, 150, 152, 154, 155, 156, 158, 161, 163, 164, 165, 166, 167, 168, 169, 175, 176, 177, 180, 183, 190, 200, 201, 202, 204, 205, 206, 207, 209, 210, 211, 212, 214, 217, 218, 220, 222, 224, 230, 232, 233, 234, 236, 239, 243, 245, 246, 251, 252, 254, 256, 258, 260, 265, 266, 267, 268, 270, 287, 290, 292, 305, 344, 439, 442, 444, 445, 446, 450, 460, 484, 485, 487, 490, 534, 550, 577, 600, 603, 605, 607, 608, 611, 612, 620, 625, 626, 632, 634, 645, 657, 665, 685, 687, 704, 705, 710, 711, 714, 715, 720, 724, 728, 730, 733, 734, 740, 741, 745, 750, 751, 753, 754, 757, 760, 761, 762, 770, 780, 794, 901, 902, 910, 920 ]:
    br.form = list(br.forms())[0]
    br["ctl00$ContentPlaceHolder1$lbLines"] = [ str(x) ]
    response = br.submit()
    match = re.search('DX..font...td..td..font color=..333333..([0-9]*,?[0-9]*)',response.read())
    if ( match ):
        print str(x) + ": " + match.group(1)

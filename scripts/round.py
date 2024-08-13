#!/usr/bin/env python3

import sys
import re

firstline = True # don't want to round the xml version number!

for line in sys.stdin:
    if firstline:
        firstline = False
        print(line, end='')
        continue
    nl = ''
    for item in re.split(r'(\d+\.\d+)', line):
        try:
            nl += re.sub(r'\.0$','',str(round(float(item), 2)))
        except ValueError:
            nl += item
    print(nl, end='')

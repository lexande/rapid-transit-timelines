#!/usr/bin/env python3

import sys
import re


for line in sys.stdin:
    nl = ''
    for item in re.split('(\d+\.\d+)', line):
        try:
            nl += str(round(float(item), 2))
        except ValueError:
            nl += item
    print(nl, end='')

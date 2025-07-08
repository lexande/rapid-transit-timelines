#!/usr/bin/env python3

import xml.etree.ElementTree as ET
import sys, subprocess, re

ET.register_namespace('', "http://www.w3.org/2000/svg")
ET.register_namespace('xlink', "http://www.w3.org/1999/xlink")
ET.register_namespace('rdf', "http://www.w3.org/1999/02/22-rdf-syntax-ns#")
ET.register_namespace('cc', "http://creativecommons.org/ns#")
ET.register_namespace('dc', "http://purl.org/dc/elements/1.1/")


dleft = int(sys.argv[1])
dright = int(sys.argv[2])
dtop = int(sys.argv[3])
dbottom = int(sys.argv[4])

tree = ET.parse(sys.argv[5])
imgelt = tree.getroot().findall("{http://www.w3.org/2000/svg}image")[0]
x = float(imgelt.get("x"))
y = float(imgelt.get("y"))
width = float(imgelt.get("width"))
height = float(imgelt.get("height"))
path = imgelt.get("{http://www.w3.org/1999/xlink}href")
metastring = str(subprocess.run(["file", path], capture_output=True).stdout)
basewidth = int(re.match('.* ([0-9]+) x ([0-9]+),.*', metastring)[1])
tilewidth = basewidth / 256
tilesize = width / tilewidth
tileheight = round(height / tilesize)
imgelt.set("x", str(x + dleft * tilesize))
imgelt.set("y", str(y + dtop * tilesize))
imgelt.set("width", str(width + (-dleft + dright) * tilesize))
imgelt.set("height", str(height + (-dtop + dbottom) * tilesize))

tree.write(sys.argv[5] + "-temp", encoding="unicode")
subprocess.run(["inkscape", "-l", "-o", sys.argv[5], sys.argv[5] + "-temp"])
subprocess.run(["rm", sys.argv[5] + "-temp"])

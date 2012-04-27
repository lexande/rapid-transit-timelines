#!/bin/bash

NAME=$(grep Timeline $1/index.html | sed -e's/.*<title>\(.*\) Rapid Transit Timeline.*/\1/')
UPPER=$(echo $1 | tr 'a-z' 'A-Z')

echo "<div style=\"display: inline-block\"><input type=\"checkbox\" id=\"${UPPER}checkbox\" onclick=\"toggleshow('$UPPER')\" checked><a href=\"$1\">$NAME</a></div>"

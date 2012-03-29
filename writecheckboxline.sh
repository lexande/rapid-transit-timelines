#!/bin/bash

NAME=$(grep Timeline $1/index.html | sed -e's/.*<title>\(.*\) Rapid Transit Timeline.*/\1/')
UPPER=$(echo $1 | tr 'a-z' 'A-Z')

echo "<input type=\"checkbox\" onclick=\"toggleshow('$UPPER')\" unchecked>$NAME</input>"

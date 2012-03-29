#!/bin/bash

NAME=$(grep Timeline $1/index.html | sed -e's/.*<title>\(.*\) Rapid Transit Timeline.*/\1/')
UPPER=$(echo $1 | tr 'a-z' 'A-Z')

echo -n '<span id="'
echo -n $UPPER
echo -n '" style="display: none; vertical-align: middle"><a href="'
echo -n $1
echo -n '">'
echo -n $NAME
echo '<br>'

echo -n '  <img name="'
echo -n $UPPER
echo -n '" src="'
echo -n $1
echo '/small/2010.png" title="2010" alt="2010 map" style="border-width: 1px; border-style: solid"></a></span>'

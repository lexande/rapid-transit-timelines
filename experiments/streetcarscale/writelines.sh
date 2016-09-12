#!/bin/bash
LOWER=$1
UPPER=$(echo $LOWER | tr 'a-z' 'A-Z')
NATIVEW=$(grep '^   width=' ${1}.svg | head -n1 | sed -e's/"$//; s/.*"//;')
W=$(awk "BEGIN{print int(0.5+$(grep '^   width=' ${1}.svg | head -n1 | sed -e's/"$//; s/.*"//;')*1169/5376)}")
H=$(awk "BEGIN{print int(0.5+$(grep '^   height=' ${1}.svg | head -n1 | sed -e's/"$//; s/.*"//;')*$W/$NATIVEW)}")
echo "<span id=\"${UPPER}\" style=\"display: inline-block; vertical-align: middle\">${2}<br>"
echo "  <img src=\"${LOWER}.svg\" title=\"${2}\" alt=\"${2} map\" style=\"border-width: 1px; border-style: solid\" height=\"${H}px\" width=\"${W}px\"></span>"
echo -n '<div style="display: inline-block"><input type="checkbox" id="'
echo -n $UPPER
echo "checkbox\" onclick=\"toggleshow('${UPPER}')\" checked>${2}</div>"

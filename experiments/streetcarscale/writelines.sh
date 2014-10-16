#!/bin/bash
LOWER=$1
UPPER=$(echo $LOWER | tr 'a-z' 'A-Z')
echo "<span id=\"${UPPER}\" style=\"display: inline-block; vertical-align: middle\">${2}<br>"
echo "  <img src=\"${LOWER}.png\" title=\"${2}\" alt=\"${2} map\" style=\"border-width: 1px; border-style: solid\"></span>"
echo -n '<div style="display: inline-block"><input type="checkbox" id="'
echo -n $UPPER
echo "checkbox\" onclick=\"toggleshow('${UPPER}')\" checked>${2}</div>"

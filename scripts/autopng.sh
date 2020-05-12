#!/bin/bash
for i in $@; do
    b=`basename $i .svg`
    if [ $i -nt ${b}.png ]; then
        W=$(awk "BEGIN{print int(0.5+$(grep '^   width=' $i | sed -e's/"$//; s/.*"//;')*30/138)}")
        sed -e's!href=".*osm.png"!href="/dev/null"!' $i > ${b}-osmless.svg
        inkscape -b ffffff -y 255 -d 20.875 -o ${b}.png24 ${b}-osmless.svg
        convert ${b}.png24 -type palette PNG8:${b}.png
        rm ${b}.png24 ${b}-osmless.svg
    fi
done

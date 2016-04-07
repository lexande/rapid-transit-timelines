#!/bin/bash
for i in $@; do
    b=`basename $i .svg`
    if [ $i -nt ${b}.png ]; then
        sed -e's!href=".*osm.png"!href="/dev/null"!' $i > ${b}-osmless.svg
        inkscape -b ffffff -d 6.52902 -e ${b}.png24 ${b}-osmless.svg
        convert ${b}.png24 -type palette PNG8:${b}.png
        rm ${b}.png24 ${b}-osmless.svg
    fi
done

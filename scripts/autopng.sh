#!/bin/bash
for i in $@; do
    b=`basename $i .svg`
    if [ $i -nt ${b}.png ]; then
        W=$(awk "BEGIN{print int(0.5+$(grep '  width=' $i | head -n1| sed -e's/"$//; s/.*"//;')*30/138)}")
        inkscape -b ffffff -y 255 -d 20.875 -o ${b}-24bit.png ${b}.svg
        convert ${b}-24bit.png -type palette PNG8:${b}.png
        rm ${b}-24bit.png
    fi
done

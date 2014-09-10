#!/bin/bash
for i in $@; do
    if [ $i -nt `basename $i .svg`.png ]; then
        inkscape -b ffffff \
                 -w $(awk "BEGIN{print int(0.5+$(grep width $i | head -n1 | sed -e's/"$//; s/.*"//;')*2*1169/5376)}") \
                 -e `basename $i .svg`.png24 $i
        convert `basename $i .svg`.png24 -type palette PNG8:`basename $i .svg`.png
        rm `basename $i .svg`.png24
    fi
done

#!/bin/bash
for i in $@; do
    if [ $i -nt `basename $i .svg`s.png ]; then
        inkscape -b ffffff \
                 -w $(awk "BEGIN{print int(0.5+$(grep width $i | head -n1 | sed -e's/"$//; s/.*"//;')*957/11008)}") \
                 -e `basename $i .svg`.png24 $i
        convert `basename $i .svg`.png24 -type palette PNG8:`basename $i .svg`s.png
        rm `basename $i .svg`.png24
    fi
done

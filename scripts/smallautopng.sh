#!/bin/bash
for i in $@; do
    if [ $i -nt `basename $i .svg`.png ]; then
        inkscape -b ffffff \
                 -w $(awk "BEGIN{print int(0.5+$(grep width $i | head -n1 | sed -e's/"$//; s/.*"//;')*390/5376)}") \
                 -e `basename $i .svg`.png $i
#        convert `basename $i .svg`.png24 -type palette PNG8:`basename $i .svg`.png
#        rm `basename $i .svg`.png24
        pngnq `basename $i .svg`.png
        mv `basename $i .svg`-nq8.png `basename $i .svg`.png
    fi
done

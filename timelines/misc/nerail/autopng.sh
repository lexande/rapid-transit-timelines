#!/bin/bash
for i in $@; do
    if [ $i -nt `basename $i .svg`.png ]; then
        inkscape -b ffffff \
                 -w $(awk "BEGIN{print int(0.5+$(grep width $i | head -n1 | sed -e's/"$//; s/.*"//;')*3192/11008)}") \
                 -e `basename $i .svg`.png $i
#        pngnq `basename $i .svg`.png
#	mv `basename $i .svg`-nq8.png `basename $i .svg`.png
    fi
done

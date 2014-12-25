#!/bin/bash
for i in $@; do
    if [ $i -nt `basename $i .svg`s.png ]; then
        inkscape -b ffffff \
                 -w $(awk "BEGIN{print int(0.5+$(grep width $i | head -n1 | sed -e's/"$//; s/.*"//;')*957/11008)}") \
                 -e `basename $i .svg`s.png $i
        pngnq `basename $i .svg`s.png
	mv `basename $i .svg`s-nq8.png `basename $i .svg`s.png
    fi
done

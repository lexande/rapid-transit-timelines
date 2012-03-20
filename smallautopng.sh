#!/bin/bash
for i in $@; do
	inkscape -b ffffff \
        	 -w $(awk "BEGIN{print int(0.5+$(grep width $i | head -n1 | sed -e's/"$//; s/.*"//;')*390/5376)}") \
                 -e `basename $i .svg`.png $i
done

#!/bin/bash
mkdir -p small
for i in $@; do
    if [ $i -nt small/$i ]; then
        ~/timelines/scripts/hideyear.pl $i > small/$i
        cd small
        if grep 'tspan1">....-....' $i; then
            mv $i temp.svg
            a=`grep 'tspan1">....-....' temp.svg | sed -e's/.*>\(....\)-.*/\1/'`
            b=`grep 'tspan1">....-....' temp.svg | sed -e's/.*>....-\(....\).*/\1/'`
            for k in `seq $a 5 $b`; do
                 sed -e"s/tspan1\">....-..../tspan1\">$k/" temp.svg > $k.svg
                 ~/timelines/scripts/smallautopng.sh $k.svg
            done
            rm temp.svg
        else
            ~/timelines/scripts/smallautopng.sh $i
        fi
        cd ..
    fi
done

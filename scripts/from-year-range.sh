#!/bin/bash
dirname=$1/small
if [ -L $dirname ]; then
    exit
fi
infile=`ls $1/*.svg | head -n1`
if grep '>....-....</tspan>' $infile >/dev/null; then
    a=`grep '>....-....</tspan>' $infile | head -n1 | sed -e's/.*>\(....\)-.*/\1/'`
    b=`grep '>....-....</tspan>' $infile | head -n1 | sed -e's/.*>....-\(....\).*/\1/'`
    echo $infile $dirname $a $b
    for k in `seq $a 5 $b`; do
        ~/timelines/scripts/hideyear.pl $infile | sed -e"s!>....-....</tspan>!>$k</tspan>!" > ${dirname}/$k.svg
        gzip -f --keep ${dirname}/$k.svg 
    done
fi

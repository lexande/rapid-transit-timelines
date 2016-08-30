#!/bin/bash
dirname=$1/small
if [ -L $dirname ]; then
    exit
fi
infile=`ls $1/*.svg | head -n1`
if grep 'tspan1">....-....' $infile >/dev/null; then
    a=`grep 'tspan1">....-....' $infile | sed -e's/.*>\(....\)-.*/\1/'`
    b=`grep 'tspan1">....-....' $infile | sed -e's/.*>....-\(....\).*/\1/'`
    echo $infile $dirname $a $b
    for k in `seq $a 5 $b`; do
	if [ $infile -nt ${dirname}/$k.svg ] || ( ! grep path ${dirname}/$k.svg >/dev/null); then
            ~/timelines/scripts/hideyear.pl $infile | sed -e"s/tspan1\">....-..../tspan1\">$k/" > ${dirname}/$k.svg
            gzip -f --keep ${dirname}/$k.svg 
        fi
    done
fi

#!/bin/bash

~/timelines/scripts/makesmall.sh *.svg
if [ -L small ]; then
    exit
fi
cd small
start=$(basename $(ls ????.svg | sort | head -n 1) .svg)
if [ $start.svg -nt 1840.svg ]; then
    lastblank=$(expr $start - 5)
    for i in `seq 1840 5 $lastblank`; do
        ~/timelines/scripts/blank.pl $i
        ~/timelines/scripts/smallautopng.sh $i.svg
        gzip --keep -f $i.svg
    done
fi
cd ..

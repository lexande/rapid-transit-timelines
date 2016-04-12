#!/bin/bash

start=$(basename $(ls ????.svg | sort | head -n 1) .svg)
lastblank=$(expr $start - 5)
cd small
for i in `seq 1840 5 $lastblank`; do
    ~/timelines/scripts/blank.pl $i
    ~/timelines/scripts/smallautopng.sh $i.svg
done
cd ..

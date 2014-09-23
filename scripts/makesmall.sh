#!/bin/bash
mkdir -p small
for i in $@; do
    if [ $i -nt small/$i ]; then
        ~/timelines/scripts/hideyear.pl $i > small/$i
        cd small
        ~/timelines/scripts/smallautopng.sh $i
        cd ..
    fi
done

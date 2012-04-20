#!/bin/bash
mkdir -p small
for i in $@; do
    sed -e's!tspan2">.*</tspan>!tspan2"></tspan>!;' $i > small/$i
    cd small
    ~/timelines/smallautopng.sh $i
    cd ..
done

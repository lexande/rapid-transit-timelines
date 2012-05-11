#!/bin/bash
mkdir -p small
for i in $@; do
    if [ $i -nt small/$i ]; then
        sed -e's!tspan2">.*</tspan>!tspan2"></tspan>!;' $i > small/$i
        cd small
        ~/timelines/scripts/smallautopng.sh $i
        cd ..
    fi
done

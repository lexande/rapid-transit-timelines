#!/bin/bash
mkdir -p small
sed -e's!tspan2">.*</tspan>!tspan2"></tspan>!;' $1 > small/$1
cd small
~/timelines/smallautopng.sh $1
cd ..

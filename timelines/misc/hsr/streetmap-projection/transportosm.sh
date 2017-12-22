#!/bin/bash
for i in `seq $1 $2`; do
	mkdir $i; cd $i
	for j in `seq $3 $4`; do
	echo https://a.tile.thunderforest.com/transport/7/$i/$j.png?apikey=13fb05a96fd244349237e1e9093983a7
	done | xargs wget -T 60 -c; rename s/.apikey=.*// *.png*; cd ..
done
for i in `seq $1 $2`; do
	montage -mode Concatenate -tile 1x`expr $4 - $3 + 1` $i/*.png $i.png
done
montage -mode Concatenate -tile `expr $2 - $1 + 1`x1 `seq $1 $2 | sed -e's/$/.png/'` osm.png

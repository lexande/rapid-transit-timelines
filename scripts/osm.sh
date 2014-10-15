#!/bin/bash
for i in `seq $1 $2`; do
	mkdir $i; cd $i
	for j in `seq $3 $4`; do
	echo http://c.tile.openstreetmap.org/14/$i/$j.png
	done | xargs wget -T 60 -c; cd ..
done
for i in `seq $1 $2`; do
	montage -mode Concatenate -tile 1x`expr $4 - $3 + 1` $i/*.png $i.png
done
montage -mode Concatenate -tile `expr $2 - $1 + 1`x1 `seq $1 $2 | sed -e's/$/.png/'` osm.png

#!/bin/bash
echo $#
if [ $# -lt 5 ]; then
	zoom=14
else
	zoom=$5
fi
echo $zoom
echo https://a.tile.thunderforest.com/transport/${zoom}/${i}/${j}.png?apikey=13fb05a96fd244349237e1e9093983a7
for i in `seq $1 $2`; do
	mkdir -p $i; cd $i
	for j in `seq $3 $4`; do
		if [ ! -f $j.png ]; then
			echo https://a.tile.thunderforest.com/transport/${zoom}/${i}/${j}.png?apikey=13fb05a96fd244349237e1e9093983a7
		fi
	done | xargs wget -T 60 -c; rename s/.apikey=.*// *.png*; cd ..
done
for i in `seq $1 $2`; do
	montage -mode Concatenate -tile 1x`expr $4 - $3 + 1` `seq $3 $4 | sed -e's/$/.png/' | sed -e"s!^!$i/!"` $i.png
done
montage -mode Concatenate -limit area 256MP -limit memory 1024MB -tile `expr $2 - $1 + 1`x1 `seq $1 $2 | sed -e's/$/.png/'` osm.png

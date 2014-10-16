#!/bin/bash
for i in `seq $1 $2`; do
	mkdir $i; cd $i
	for j in `seq $3 $4`; do
		echo http://t3.beta.itoworld.com/15/68855e0267afec21a9274b489f3e05cd/11/$i/$j.png
	done | xargs wget -T 60 -c
        cd ..
done
for i in `seq $1 $2`; do
        montage -mode Concatenate -tile 1x`expr $4 - $3 + 1` $(seq $3 $4 | perl -wpe"s!^!$i/!; s/\n/.png /;") $i.png
done
montage -mode Concatenate -tile `expr $2 - $1 + 1`x1 `seq $1 $2 | sed -e's/$/.png/'` osm.png

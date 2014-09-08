#!/bin/bash
START=$(basename $(ls *.svg | grep '^1\|^2' | head -n 1) .svg)
if [ -f $(expr $START + 5).svg ]; then
	STEP=5
else
	STEP=10
fi
COUNT=$(expr 1 + \( 2015 - $START \) / $STEP)
sed -e"s/START/${START}/g; s/STEP/${STEP}/g; s/COUNT/${COUNT}/g; s/CITYNAME/$1/;" ~/timelines/scripts/boilerplate/car > index.html
for i in *.svg; do
	echo \<img src=\"`basename $i .svg`.png\" width=\"1\" height=\"1\" alt=\"\"\> >> index.html
done
cat ~/timelines/scripts/boilerplate/$2 >> index.html

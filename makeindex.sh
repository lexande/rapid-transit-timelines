#!/bin/bash
START=$(basename $(ls *.svg | grep '^1\|^2' | head -n 1) .svg)
if [ -f $(expr $START + 5).svg ]; then
	STEP=5
else
	STEP=10
fi
COUNT=$(expr 1 + \( 2010 - $START \) / $STEP)
sed -e"s/START/${START}/g; s/STEP/${STEP}/g; s/COUNT/${COUNT}/g; s/CITYNAME/$1/;" ~/timelines/boilerplate/car > index.html
cat ~/timelines/boilerplate/$2 >> index.html

#!/bin/bash
START=$(basename $(ls *.svg | grep '^1\|^2' | head -n 1) .svg)
END=$(basename $(ls *.svg | grep '^1\|^2' | tail -n 1) .svg)
if [ -f $(expr $START + 1).svg ]; then
        STEP=1
        COUNT=$(expr 1 + \( $END - $START \))
        INDEX="count-1"
        SNAME="one year"

elif [ -f $(expr $START + 5).svg ]; then
	STEP=5
	COUNT=$(expr 1 + \( 2015 - $START \) / 5)
	INDEX="count-2"
	SNAME="five years"
else
	STEP=10
	COUNT=$(expr 1 + \( $END - $START \) / 10)
	INDEX="count-1"
	SNAME="ten years"
fi
CITYNAME=`cat name`
sed -e"s/START/${START}/g; 
s/STEP/${STEP}/g; 
s/COUNT/${COUNT}/g; 
s/CITYNAME/${CITYNAME}/g;
s/INDEX/${INDEX}/g;
s/SNAME/${SNAME}/g;" ~/timelines/scripts/boilerplate/car > index.html
for i in *.svg; do
	year=`basename $i .svg`
	echo \<a href=\"#${year}\" onclick=\"gotoyear\(${year}\)\"\>${year}\</a\> >> index.html
done
sed -e"s/SNAME/${SNAME}/g" ~/timelines/scripts/boilerplate/cadr >> index.html
for i in *.svg; do
	echo \<img src=\"`basename $i .svg`.png\" width=\"1\" height=\"1\" alt=\"\"\> >> index.html
done
sed -e"s!<a href=.*>${CITYNAME}</a>!${CITYNAME}!" ~/timelines/scripts/boilerplate/$1 >> index.html
if [ -d uncropped ]; then
	 sed -e's!\.\.!\.\./\.\.!' index.html > uncropped/index.html
fi

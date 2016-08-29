#!/bin/bash
pushd $1
START=$(basename $(ls *.svg | grep '^1\|^2' | head -n 1) .svg)
END=$(basename $(ls *.svg | grep '^1\|^2' | tail -n 1) .svg)
if [ $END == 2020 ]; then
	END=2015
fi
if [ -f $(expr $START + 1).svg ]; then
        STEP=1
        COUNT=$(expr 1 + \( $END - $START \))
        INDEX="count-1"
        SNAME="one year"

elif [ -f $(expr $START + 5).svg ]; then
	STEP=5
	COUNT=$(expr 1 + \( $END - $START \) / 5)
	INDEX="count-1"
	SNAME="five years"
else
	STEP=10
	COUNT=$(expr 1 + \( $END - $START \) / 10)
	INDEX="count-1"
	SNAME="ten years"
fi
if [ $(basename $(pwd)) == 'uncropped' ]; then
	CITYNAME=`cat ../name`
	CONTINENT=`cat ../c`
else
	CITYNAME=`cat name`
	CONTINENT=`cat c`
fi
NATIVEW=$(grep '^   width=' ${END}.svg | head -n1 | sed -e's/"$//; s/.*"//;')
W=$(awk "BEGIN{print int(0.5+$(grep '^   width=' ${END}.svg | head -n1 | sed -e's/"$//; s/.*"//;')*1169/5376)}")
H=$(awk "BEGIN{print int(0.5+$(grep '^   height=' ${END}.svg | head -n1 | sed -e's/"$//; s/.*"//;')*$W/$NATIVEW)}")

sed -e"s/START/${START}/g; 
s/STEP/${STEP}/g; 
s/COUNT/${COUNT}/g; 
s/CITYNAME/${CITYNAME}/g;
s/INDEX/${INDEX}/g;
s/SNAME/${SNAME}/g;
s/WIDTH/${W}/g;
s/HEIGHT/${H}/g;" ~/timelines/scripts/boilerplate/car > index.html
for year in $(seq $START $STEP $END); do
	echo \<a href=\"#${year}\" onclick=\"gotoyear\(${year}\)\"\>${year}\</a\> >> index.html
done
sed -e"s/SNAME/${SNAME}/g" ~/timelines/scripts/boilerplate/cadr >> index.html
for year in $(seq $START $STEP $END); do
	echo \<img src=\"${year}.svg\" width=\"1\" height=\"1\" alt=\"\"\> >> index.html
done
sed -e"s!<a href=.*>${CITYNAME}</a>!${CITYNAME}!" ~/timelines/scripts/boilerplate/${CONTINENT} >> index.html
if [ $(basename $(pwd)) == 'uncropped' ]; then
	sed -e's!\.\.!\.\./\.\.!' -i index.html
fi
if [ $(basename $(pwd)) == 'nyc' -o $(basename $(pwd)) == 'chi' -o $(basename $(pwd)) == 'bos' ]; then
	sed -e's!\.\./\.\.!!; s!\.\.!/timelines!' -i index.html
fi
popd

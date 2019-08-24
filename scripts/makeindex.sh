#!/bin/bash
pushd $1
START=$(basename $(ls *.svg | grep '^1\|^2' | head -n 1) .svg)
END=$(basename $(ls *.svg | grep '^1\|^2' | tail -n 1) .svg)
if [ -f $(expr $START + 1).svg ]; then
        STEP=1
        COUNT=$(expr 1 + \( $END - $START \))
        SNAME="one year"
elif [ -f $(expr $START + 10).svg ] && [ ! -f $(expr $START + 5).svg ]; then
	STEP=10
	COUNT=$(expr 1 + \( $END - $START \) / 10)
	SNAME="ten years"
else
	STEP=5
	COUNT=$(expr 1 + \( $END - $START \) / 5)
	SNAME="five years"
fi
if [ $END == 2020 ] && [ $START != 2020 ]; then
	INDEX="count-2"
	DISPLAY=$(expr $END - $STEP)
else
	INDEX="count-1"
	DISPLAY=$END
fi

if [ $(basename $(pwd)) == 'uncropped' ]; then
	CITYNAME=`cat ../name | sed -e's/<br>/ /'`
else
	CITYNAME=`cat name | sed -e's/<br>/ /'`
fi
NATIVEW=$(grep '^   width=' ${END}.svg | head -n1 | sed -e's/"$//; s/.*"//;')
W=$(awk "BEGIN{print int(0.5+$(grep '^   width=' ${END}.svg | head -n1 | sed -e's/"$//; s/.*"//;')*30/138)}")
H=$(awk "BEGIN{print int(0.5+$(grep '^   height=' ${END}.svg | head -n1 | sed -e's/"$//; s/.*"//;')*$W/$NATIVEW)}")

sed -e"s/START/${START}/g; 
s/STEP/${STEP}/g; 
s/COUNT/${COUNT}/g; 
s!CITYNAME!${CITYNAME}!g;
s/DISPLAY/${DISPLAY}/g;
s/INDEX/${INDEX}/g;
s/SNAME/${SNAME}/g;
s/WIDTH/${W}/g;
s/HEIGHT/${H}/g;" ~/timelines/scripts/boilerplate/part1 > index.html
for year in $(seq $START $STEP $END); do
	echo \<a href=\"#${year}\" onclick=\"gotoyear\(${year}\)\"\>${year}\</a\> >> index.html
done
if [ -d uncropped ]; then
	sed -e"s/SNAME/${SNAME}/g" ~/timelines/scripts/boilerplate/part2u >> index.html
else
	sed -e"s/SNAME/${SNAME}/g" ~/timelines/scripts/boilerplate/part2 >> index.html
fi
for year in $(seq $START $STEP $END); do
	echo \<img src=\"${year}.svg\" width=\"1\" height=\"1\" alt=\"\"\> >> index.html
done
sed -e"s!<a href=.*>${CITYNAME}</a>!${CITYNAME}!" ~/timelines/scripts/boilerplate/part3 >> index.html
if [ -f seealso ]; then
	cat seealso >> index.html
elif [ $(basename $(pwd)) == 'uncropped' ] && [ -f ../seealso ]; then
	cat ../seealso >> index.html
fi
cat ~/timelines/scripts/boilerplate/part4 >> index.html
if [ $(basename $(pwd)) == 'uncropped' ]; then
	sed -e's!\.\.!\.\./\.\.!' -i index.html
fi
if [ $(basename $(pwd)) == 'nyc' -o $(basename $(pwd)) == 'bos' ]; then
	sed -e's!\.\./\.\.!!; s!\.\.!/timelines!' -i index.html
fi
popd

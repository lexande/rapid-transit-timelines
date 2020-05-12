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
INDEX="count-1"
DISPLAY=$END

if [ $(basename ${PWD}) == 'uncropped' ]; then
	CITYNAME=`cat ../name | sed -e's/<br>/ /'`
else
	CITYNAME=`cat name | sed -e's/<br>/ /'`
fi
NATIVEW=$(grep '^   width=' ${END}.svg | head -n1 | sed -e's/"$//; s/.*"//;')
W=$(awk "BEGIN{print int(0.5+$(grep '^   width=' ${END}.svg | head -n1 | sed -e's/"$//; s/.*"//;')*30/138)}")
H=$(awk "BEGIN{print int(0.5+$(grep '^   height=' ${END}.svg | head -n1 | sed -e's/"$//; s/.*"//;')*$W/$NATIVEW)}")

if [ $(basename ${PWD}) == 'nyc' ]; then
	URL="subtimeline"
elif [ $(basename ${PWD}) == 'bos' ]; then
	URL="ttimeline"
elif [ $(basename ${PWD}) == 'uncropped' ]; then
	if [ $(basename ${PWD%/*}) == 'nyc' ]; then
		URL="subtimeline/uncropped"
	else
		URL=timelines/$(basename ${PWD%/*})/uncropped
	fi
else
	URL=timelines/$(basename ${PWD})
fi

PREVDIM=$(file preview.gif | sed -e's/.* \([0-9]* x [0-9]*\).*/\1/')

sed -e"s/START/${START}/g; 
s/END/${END}/g;
s/STEP/${STEP}/g; 
s/COUNT/${COUNT}/g; 
s!CITYNAME!${CITYNAME}!g;
s/DISPLAY/${DISPLAY}/g;
s/INDEX/${INDEX}/g;
s/SNAME/${SNAME}/g;
s/WIDTH/${W}/g;
s/HEIGHT/${H}/g;
s/PREVW/${PREVDIM% x*}/g;
s/PREVH/${PREVDIM#*x }/g;
s!URL!${URL}!g;" ~/timelines/scripts/template/part1 > index.html
for year in $(seq $START $STEP $END); do
	echo \<a href=\"#${year}\" onclick=\"gotoyear\(${year}\)\"\>${year}\</a\> >> index.html
done
if [ -d uncropped ]; then
	sed -e"s/SNAME/${SNAME}/g" ~/timelines/scripts/template/part2u >> index.html
else
	sed -e"s/SNAME/${SNAME}/g" ~/timelines/scripts/template/part2 >> index.html
fi
for year in $(seq $START $STEP $END); do
	echo \<img src=\"${year}.svg\" width=\"1\" height=\"1\" alt=\"\"\> >> index.html
done
sed -e"s!<a href=.*>${CITYNAME}</a>!${CITYNAME}!" ~/timelines/scripts/template/part3 >> index.html
if [ -f seealso ]; then
	cat seealso >> index.html
elif [ $(basename ${PWD}) == 'uncropped' ] && [ -f ../seealso ]; then
	cat ../seealso >> index.html
fi
cat ~/timelines/scripts/template/part4 >> index.html
if [ $(basename ${PWD}) == 'nyc' -o $(basename ${PWD}) == 'bos' -o $(basename ${PWD%/*}) == 'nyc' ]; then
	sed -e's!\.\./\.\.!!; s!\.\.!/timelines!' -i index.html
elif [ $(basename ${PWD}) == 'uncropped' ]; then
	sed -e's!\.\.!\.\./\.\.!' -i index.html
fi
popd

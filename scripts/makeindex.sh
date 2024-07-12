#!/bin/bash
pushd $1 >/dev/null

SCRIPTDIR=$(dirname $0)
START=$(basename $(grep -l 'stroke-width:[3-7]' [0-9]*.svg | sort -g | head -n1) .svg)
END=$(basename $(ls [0-9]*.svg | sort -g | tail -n1) .svg)
STEP=5
SNAME="five years"
FINALSTEP=$(($END % 5))
if [ $FINALSTEP -gt 0 ]; then
	COUNT=$((2 + ( $END - $FINALSTEP - $START ) / 5))
else
	COUNT=$((1 + ( $END - $START ) / 5))
fi
INDEX="count-1"
DISPLAY=$END

if [ $(basename ${PWD}) == 'uncropped' ]; then
	CITYNAME=`cat ../name | sed -e's/<br>/ /'`
else
	CITYNAME=`cat name | sed -e's/<br>/ /'`
fi
NATIVEW=$(grep '^   width=' ${END}.svg | head -n1 | sed -e's/"$//; s/.*"//;')
W=$(awk "BEGIN{print int(0.5+$(grep '^   width=' ${END}.svg | head -n1 \
    | sed -e's/"$//; s/.*"//;')*30/138)}")
H=$(awk "BEGIN{print int(0.5+$(grep '^   height=' ${END}.svg | head -n1 \
    | sed -e's/"$//; s/.*"//;')*$W/$NATIVEW)}")

if [ $(basename ${PWD%/*}) == 'misc' ]; then
	URL=timelines/misc/$(basename ${PWD})
elif [ $(basename ${PWD}) == 'uncropped' ]; then
	URL=timelines/$(basename ${PWD%/*})/uncropped
else
	URL=timelines/$(basename ${PWD})
fi

if [ ! -f key ]; then
	MODE="Rapid Transit"
elif grep trolleybuses key >/dev/null; then
	MODE="Rail and Trolleybus"
else
	MODE="Rail"
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
s!URL!${URL}!g;
s/MODE/${MODE}/g;" ${SCRIPTDIR}/template/part1
for year in $(seq $START $STEP $END); do
	echo \<a href=\"#${year}\" onclick=\"gotoyear\(${year}\)\"\>${year}\</a\>
done
if [ $FINALSTEP -gt 0 ]; then
	echo \<a href=\"#${END}\" onclick=\"gotoEND\(${END}\)\"\>${END}\</a\>
fi
echo '<p>'
grep earlier ${SCRIPTDIR}/template/part1 | sed -e"s/SNAME/${SNAME}/g"
grep later ${SCRIPTDIR}/template/part1 | sed -e"s/SNAME/${SNAME}/g"
echo '<p>'
if [ -d uncropped ]; then
	echo '<a href="uncropped">click here for uncropped version</a><p>'
fi
if [ -f key ]; then
	cat key
	grep -v frequent ${SCRIPTDIR}/template/part2
elif [ $(basename ${PWD}) == 'uncropped' ]; then
	sed -e"s%\.\.%\.\./\.\.%;" ${SCRIPTDIR}/template/part2
else
	cat ${SCRIPTDIR}/template/part2
fi
for year in $(seq $START $STEP $(($END - 1))); do
	echo \<img src=\"${year}.svg\" width=\"1\" height=\"1\" alt=\"\"\>
done
echo '</div>'
echo 'See also:'
if [ $(basename ${PWD%/*}) == 'misc' ]; then
	if [ -f seealso ]; then
		cat seealso
	fi
	echo '<a href="../..">rapid transit timelines</a> -'
	echo '<a href="..">miscellaneous timelines and maps</a>'
elif [ $(basename ${PWD}) == 'uncropped' ]; then
	sed -e"s%\.\.%\.\./\.\.%; s%<a href=.*>\(${CITYNAME}\)</a>%\1%" ${SCRIPTDIR}/template/part3
	if [ -f ../seealso ]; then
		sed -e"s%\.\.%\.\./\.\.%" ../seealso
	fi
else
	sed -e"s%<a href=.*>\(${CITYNAME}\)</a>%\1%" ${SCRIPTDIR}/template/part3
	if [ -f seealso ]; then
		cat seealso
	fi
fi

cat ${SCRIPTDIR}/template/part4
popd >/dev/null

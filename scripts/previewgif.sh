#!/bin/bash
mkdir -p anim
for i in $1/*.svg; do
  ~/timelines/scripts/hideyear.pl $i > anim/`basename $i`
done
cd anim
for i in *.svg; do
  echo -n "$i "
  width=$(grep '^   width=' $i | sed -e's/   width="\(.*\)"/\1/')
  height=$(grep '^   height=' $i | sed -e's/   height="\(.*\)"/\1/')
  sed -e's!href=".*osm.png"!href="/dev/null"!' $i > osmless-${i}
  inkscape -b ffffff -w 600 -e ${i}.png osmless-${i} >/dev/null 
  convert ${i}.png ${i}.gif
done
echo ""
gifsicle -l -d 100 --colors 256 `ls *.svg.gif | tail -n1` *.svg.gif > ../$1/preview.gif
cd ..
rm -r anim

#!/bin/bash
mkdir -p anim
nonempty=false
for i in $1/*.svg; do
  if grep 'stroke-width:[2-5]' $i | grep -v 'stroke:none' >/dev/null; then nonempty=true; fi
  if $nonempty; then ~/timelines/scripts/hideyear.pl $i > anim/`basename $i`; fi
done
cd anim
for i in `ls *.svg | sort -g`; do
  echo -n "$i "
  width=$(grep '^   width=' $i | sed -e's/   width="\(.*\)"/\1/')
  height=$(grep '^   height=' $i | sed -e's/   height="\(.*\)"/\1/')
  sed -e's!href=".*osm.png"!href="/dev/null"!' $i > osmless-${i}
  inkscape -b ffffff -w 600 -e ${i}.png osmless-${i} >/dev/null 
  convert ${i}.png ${i}.gif
done
echo ""
if [ `ls *.svg.gif | wc -l` -gt 1 ]; then
  gifsicle -l -d 100 --colors 256 `ls *.svg.gif | tail -n1` *.svg.gif > ../$1/preview.gif
else
  mv *.svg.gif ../$1/preview.gif
fi
cd ..
rm -r anim

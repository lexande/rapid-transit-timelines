#!/bin/bash
mkdir -p anim
nonempty=false
cp $1/*.svg anim
cd anim
for i in `ls *.svg | sort -g`; do
  echo -n "$i "
  width=$(grep '^   width=' $i | sed -e's/   width="\(.*\)"/\1/')
  height=$(grep '^   height=' $i | sed -e's/   height="\(.*\)"/\1/')
  sed -e's!href=".*osm.png"!href="/dev/null"!' $i > osmless-${i}
  inkscape -b '#ffffff' -y 255 -w 600 -o ${i}.png osmless-${i} >/dev/null 2>&1
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

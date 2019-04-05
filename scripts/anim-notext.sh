#!/bin/bash
mkdir -p anim
for i in $1/*.svg; do
  ~/timelines/scripts/hideyear.pl $i > anim/`basename $i`
done
cd anim
for i in *.svg; do
  ~/timelines/scripts/autopng.sh $i
  convert `basename $i .svg`.png $i.gif
done
gifsicle -l -d 100 --colors 256 *.svg.gif > ../$1/animated.gif
cd ..
rm -r anim

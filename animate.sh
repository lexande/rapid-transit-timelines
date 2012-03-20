#!/bin/bash
for i in 1*.png 2*.png; do
  convert $i $i.gif
done
gifsicle -l -d 100 --colors 256 *.png.gif > animated.gif
rm 1*.png.gif 2*.png.gif

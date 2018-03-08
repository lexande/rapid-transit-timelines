#!/bin/bash
mkdir -p anim
for i in $1/*.svg; do
  cp $i anim
done
cd anim
rm -f 2020.svg
sed -e's!</svg>!!' -i *.svg
WIDTH=$(grep width 2010.svg | head -n1 | sed -e's/"$//; s/.*"//; s/\..*//;')
HEIGHT=$(grep height 2010.svg | head -n1 | sed -e's/"$//; s/.*"//; s/\..*//;')
XMIN=$(grep viewBox 2010.svg | head -n1 | perl -wpe's/.*"(-?[0-9]*),? .* .* .*"$/$1/')
YMIN=$(grep viewBox 2010.svg | head -n1 | perl -wpe's/.*".* (-?[0-9]*),? .* .*"$/$1/')
XPOS=$(expr $WIDTH + $XMIN - 2400)
YPOS=$(expr $HEIGHT + $YMIN - 40)
for i in *.svg; do
  cat >> $i <<EOF
  <text
     x="$XPOS"
     y="$YPOS"
     id="text3057"
     xml:space="preserve"
     style="font-size:40px;font-style:normal;font-weight:normal;line-height:125%;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;font-family:Sans;-inkscape-font-specification:Sans"><tspan
       x="$XPOS"
       y="$YPOS"
       id="tspan3059">©CC-BY-SA Alexander Rapp based on data from OpenStreetMap        http://alexander.co.tz/$1</tspan></text>
</svg>
EOF
  ~/timelines/scripts/autopng.sh $i
  convert `basename $i .svg`.png $i.gif
done
gifsicle -l -d 100 --colors 256 *.svg.gif > ../$1/animated.gif
cd ..
rm -r anim

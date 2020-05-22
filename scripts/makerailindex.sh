#!/bin/bash
START=$(basename $(grep 'stroke-width:5' $1/1*.svg $1/2*.svg | head -n1 | sed -e's/:.*//') .svg)
END=2010
COUNT=$(expr 1 + \( $END - $START \) / 25)
NAME=`cat $1/name | sed -e's/<br>/ /'`
SCALE=$2
NATIVEW=$(grep '^   width=' $1/${END}.svg | head -n1 | sed -e's/"$//; s/.*"//;')
W=$(awk "BEGIN{print int(0.5+$(grep '^   width=' $1/${END}.svg | head -n1 | sed -e's/"$//; s/.*"//;')*${SCALE}/17.25)}")
H=$(awk "BEGIN{print int(0.5+$(grep '^   height=' $1/${END}.svg | head -n1 | sed -e's/"$//; s/.*"//;')*$W/$NATIVEW)}")
DIRNAME=$(basename $(realpath $1))
PREVDIM=$(file preview.gif | sed -e's/.* \([0-9]* x [0-9]*\).*/\1/')
cat <<HEREDOC | sed -e"s/START/${START}/g;
s/COUNT/${COUNT}/g; 
s!NAME!${NAME}!g;
s/URL/${DIRNAME}/g;
s/PREVW/${PREVDIM% x*}/g;
s/PREVH/${PREVDIM#*x }/g;
s/START/${START}/g;
s/END/${END}/g;"
<!DOCTYPE HTML>
<html>
<head><title>NAME Passenger Rail Timeline</title>
<meta http-equiv="Content-type" content="text/html;charset=UTF-8">
<meta property="og:type" content="website" />
<meta property="og:title" content="NAME Passenger Rail Timeline" />
<meta property="og:image" content="https://alexander.co.tz/timelines/misc/URL/preview.gif" />
<meta property="og:image:width" content="PREVW" />
<meta property="og:image:height" content="PREVH" />
<meta property="og:url" content="https://alexander.co.tz/timelines/misc/URL/preview.gif" />
<meta property="og:description" content="Maps every 25 years, START-END" />
<meta name="twitter:card" content="summary_large_image" />
<style type="text/css">
div#preloader {
	position: absolute;
	left: -9999px;
	top:  -9999px;
}
div#preloader img {
	display: block;
}
img {
	border: 1px solid;
}
body {
	text-align: center;
}
</style>
<script language="JavaScript" type="text/javascript">
start=START;
count=COUNT;
step=25;
index=count-1;
function update() {
	map = document.getElementById("map");
	map.src=(start+step*index) + ".svg";
	map.title=start+step*index;
	map.alt=start+step*index + " map";
HEREDOC
if [ $SCALE = 1.5 ]; then
  echo '	document.getElementById("link").href="large.html#" + (start+step*index);'
fi
cat << HEREDOC
	location.replace("#" + (start+step*index));
}
function nextmap() {
	index=(index+1)%count;
	update();
}
function prevmap() {
	index=(index+count-1)%count;
	update();
}
document.onkeydown=function(keypress) {
	if(keypress.which == 65) { prevmap(); }
	if(keypress.which == 83) { nextmap(); }
}
function gotoyear(x) {
	inyear = parseInt(x);
	if( start <= inyear & inyear <= start+step*count & !((inyear-start) % step) ) {
		index = (inyear-start)/step;
		update();
	}
}
intervalID=0;
function startanim() {
	intervalID = setInterval(nextmap, 1000);
	animbutton = document.getElementById("animbutton");
	animbutton.onclick = stopanim;
	animbutton.innerText = "click here to stop animation";
}
function stopanim() {
	clearInterval(intervalID);
	animbutton = document.getElementById("animbutton");
	animbutton.onclick = startanim;
	animbutton.innerText = "click here to animate";
}
window.onload=function() {
	gotoyear(location.hash.substring(1));
}
window.onhashchange=function() {
	gotoyear(location.hash.substring(1));
}
</script>
<script type="text/javascript">
  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-19998781-1']);
  _gaq.push(['_trackPageview']);
  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();
</script>
</head><body>
HEREDOC
if [ $SCALE = 1.5 ]; then
  echo 'smaller version --- <a href="large.html">larger version</a>'
else
  echo '<a href=".">smaller version</a> --- larger version'
fi
cat <<HEREDOC
<p>
<a href="javascript:" onclick="prevmap()">25 years earlier (or press a)</a> ---
<a href="javascript:" onclick="nextmap()">25 years later (or press s)</a>
<br>
<a id="animbutton" href="javascript:" onclick="startanim()">click here to animate</a>
<p>
HEREDOC
if [ $SCALE = 1.5 ]; then
  echo '<a id="link" href="large.html">'
else
  echo '<a href="javascript:" onclick="nextmap()">'
fi 
echo '<img id="map" src="2010.svg" title="2010" alt="2010 map" width="'${W}'" height="'${H}'">'
echo '</a>'
echo '<p>'
for year in $(seq $START 25 $END); do
	echo \<a href=\"#${year}\" onclick=\"gotoyear\(${year}\)\"\>${year}\</a\>
done
cat <<HEREDOC
<p>
<a href="javascript:" onclick="prevmap()">25 years earlier (or press a)</a> --- 
<a href="javascript:" onclick="nextmap()">25 years later (or press s)</a>
<p>
Showing those lines with at least three trains per direction each weekday.  Lines coloured by operator (<a href="colours.html">key</a>).<br>
HEREDOC
echo 'Scale: <svg width="'`echo 100*${SCALE} | bc`'px" height="3px" style="vertical-align: middle; stroke-width: 0px; background-color: black;"/> ≈ 100 km (approximately '${SCALE}' CSS pixels per km)'
cat <<HEREDOC
<p>
Please send any corrections or questions to threestationsquare at gmail dot com.
<p>
<div id="preloader">
HEREDOC
for year in $(seq $START 25 $END); do
	echo \<img src=\"${year}.svg\" width=\"1\" height=\"1\" alt=\"\"\>
done
echo '</div>'
first=1
for link in nerail carail; do
  if [ $DIRNAME = $link ]; then continue; fi
  if [ $first = 1 ]; then
    echo -n "See also: "
    first=0
  else
    echo " - "
  fi
  echo -n '<a href="../'$link'">'`cat ~/timelines/timelines/misc/${link}/name`' passenger rail timeline</a>'
done
echo ''
if [ -f seealso ]; then
  cat seealso
fi
echo '<br>'
first=1
for city in `cat $1/cities`; do
  if [ $first = 1 ]; then
    echo -n "rapid transit timelines for "
    first=0
  else
    echo " - "
  fi
  echo -n '<a href="'
  if [ $city = nyc ]; then
    echo -n "/subtimeline"
  elif [ $city = bos ]; then
    echo -n "/ttimeline"
  else
    echo -n "../../${city}"
  fi
  echo -n '">'$(cat ~/timelines/timelines/${city}/name)"</a>"
done
cat <<HEREDOC

<br>
<a href="../..">other rapid transit timelines</a> -
<a href="..">miscellaneous timelines and maps</a>
HEREDOC
cat ~/timelines/scripts/template/part4

#!/bin/bash
cat <<HEREDOC
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><title>UNTITLED Rapid Transit Timelines</title>
<meta http-equiv="Content-type" content="text/html;charset=UTF-8">
<style type="text/css">
div#preloader {
	position: absolute;
	left: -9999px;
	top:  -9999px;
}
div#preloader img {
	display: block;
}
div#sidebar {
	position:fixed;
	height: 100%;
	width: 11em;
	top: 0;
	left: 0;
	margin: 2px;
	overflow: auto;
}
body {
	padding-left: 11em;
}
</style>
<script language="JavaScript" type="text/javascript">
HEREDOC
start=$(for city in `echo $@ | sed -e's/@//g'`; do ls $city/????.svg; done | sed -e's!^.../\(....\).svg!\1!' | sort | head -n 1)
echo "start=${start};"
echo -n "count="
expr 1 + \( \( 2015 - $start \) / 5 \) | sed -e's/$/;/'
cat <<HEREDOC
step=5;
index=count-1;
function update() {
HEREDOC
echo -n '	['
for city in $@; do echo -n '"'$city'",'; done | tr 'a-z' 'A-Z' | sed -e's/@//g; s/,$/].forEach(function(city) { if (document.getElementById(city).style.display == "inline-block") {/'
echo ''
cat << HEREDOC
		mapimg = document.getElementById(city + "map");
		mapimg.src = (city.toLowerCase() + "/small/" + (start+step*index) + ".svg");
		mapimg.title = start+step*index;
		mapimg.alt = start+step*index + " map";
	}});
}
function nextmap() {
	index = (index+1)%count;
	update();
}
function prevmap() {
	index = (index+count-1)%count;
	update();
}
function toggleshow(x) {
	span = document.getElementById(x);
	prediv = document.getElementById(x + "pre");
	mapimg = document.getElementById(x + "map");
	if (span.style.display == 'inline-block') {
		span.style.display = 'none';
		mapimg.src = "about:blank";
		for (var img of prediv.getElementsByTagName("img")) {
			prediv.removeChild(img);
		}
	} else {
		mapimg.src = x.toLowerCase() + '/small/' + (start+step*index) + '.svg';
		for (var i = start; i < start + count*step; i+=step) {
			img = document.createElement("img");
			img.src = x.toLowerCase() + '/small/' + i + '.svg';
			img.width = "1"; img.height = "1"; img.alt = "";
			prediv.appendChild(img);
		}
		span.style.display = 'inline-block';
	}
}

document.onkeydown=function(keypress) {
	if(keypress.which == 65) { prevmap(); }
	if(keypress.which == 83) { nextmap(); }
}
window.onload=function() {
	inyear = parseInt(location.hash.substring(1));
	if( start < inyear & inyear < start+step*count & !(inyear % step) ) {
		index = (inyear-start)/step;
		update();
	}
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
<center>
<a href="javascript:prevmap()">five years earlier (or press a)</a> ---
<a href="javascript:nextmap()">five years later (or press s)</a>
<p>
HEREDOC

for c in $@; do
  city=`echo $c | sed -e's/@//'`
  NAME=`cat $city/name`
  UPPER=$(echo $city | tr 'a-z' 'A-Z')
  NATIVEW=$(grep ' width="' $city/small/2015.svg | head -n1 | sed -e's/.* width="\([0-9\.]*\)".*/\1/;')
  W=$(awk "BEGIN{print int(0.5+$NATIVEW*390/5376)}")
  H=$(awk "BEGIN{print int(0.5+$(grep ' height=' $city/small/2015.svg | head -n1 | sed -e's/.* height="\([0-9\.]*\)".*/\1/;')*$W/$NATIVEW)}")
  if (echo $c | grep '@' >/dev/null); then
    echo '<span id="'$UPPER'" style="display: none; vertical-align: middle"><a href="'$city'">'$NAME'<br>' \
      | sed -e's!href="nyc"!href="../subtimeline/"!; s!href="chi"!href="../ltimeline"!; s!href="bos"!href="../ttimeline"!;'
    echo '  <img id="'$UPPER'map" src="about:blank" title="2015" alt="2015 map" width="'$W'px" height="'$H'px" style="border-width: 1px; border-style: solid"></a></span>'
  else
    echo '<span id="'$UPPER'" style="display: inline-block; vertical-align: middle"><a href="'$city'">'$NAME'<br>' \
      | sed -e's!href="nyc"!href="../subtimeline/"!; s!href="chi"!href="../ltimeline"!; s!href="bos"!href="../ttimeline"!;'
    echo '  <img id="'$UPPER'map" src="'$city'/small/2015.svg" title="2015" alt="2015 map" width="'$W'px" height="'$H'px" style="border-width: 1px; border-style: solid"></a></span>'
  fi
done

cat <<HEREDOC
<p>
<a href="javascript:prevmap()">five years earlier (or press a)</a> --- 
<a href="javascript:nextmap()">five years later (or press s)</a>
<p>
<p>
Based on frequent midday service at the end of the year in question (<a href="notes.html">notes</a>).  Scale 10 CSS pixels per km.
<p>
Please send any corrections or questions to threestationsquare at gmail dot com.
<p>
<font size="1">By <a href="/">Alexander Rapp</a> based on map data 
<a rel="license" href="http://creativecommons.org/licenses/by-sa/2.0/"><img alt="CC-BY-SA" style="border-width:0" src="http://i.creativecommons.org/l/by-sa/2.0/80x15.png"></a>
by <a href="http://www.openstreetmap.org">OpenStreetMap</a> contributors.</font>
</center>
<div id=sidebar><form action="">Cities to show (ordered by opening year):<br>
HEREDOC
for c in $@; do
  city=`echo $c | sed -e's/@//'`
  NAME=`cat $city/name`
  UPPER=$(echo $city | tr 'a-z' 'A-Z')
  if (echo $c | grep '@' >/dev/null); then 
    echo "<div style=\"display: inline-block\"><input type=\"checkbox\" id=\"${UPPER}checkbox\" onclick=\"toggleshow('$UPPER')\"><a href=\"$city\">$NAME</a></div><br>" \
      | sed -e's!href="nyc"!href="../subtimeline/"!; s!href="chi"!href="../ltimeline"!; s!href="bos"!href="../ttimeline"!;'
  else
    echo "<div style=\"display: inline-block\"><input type=\"checkbox\" id=\"${UPPER}checkbox\" onclick=\"toggleshow('$UPPER')\" checked><a href=\"$city\">$NAME</a></div><br>" \
      | sed -e's!href="nyc"!href="../subtimeline/"!; s!href="chi"!href="../ltimeline"!; s!href="bos"!href="../ttimeline"!;'
  fi
done
echo "</form></div>"
echo "<div id=preloader>"
for c in $@; do
  city=`echo $c | sed -e's/@//'`
  UPPER=`echo $city | tr 'a-z' 'A-Z'`
  echo '<div id="'$UPPER'pre">'
  if (echo $c | grep '@' >/dev/null); then
    true
  else
    for year in `seq $start 5 2015`; do
      echo '<img src="'$city'/small/'$year'.svg" width="1" height="1" alt="">'
    done
  fi
  echo '</div>'
done

cat <<HEREDOC
</div>
<script>
if (location.hash == "#n") {
	toggleshow("PHL");
	location.hash = "";
}
</script>
</body></html>
HEREDOC

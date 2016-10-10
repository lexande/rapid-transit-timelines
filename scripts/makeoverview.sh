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
</style>
<script language="JavaScript" type="text/javascript">
HEREDOC
start=$(for city in $@; do ls $city/????.svg; done | sed -e's!^.../\(....\).svg!\1!' | sort | head -n 1)
echo "start=${start};"
echo -n "count="
expr 1 + \( \( 2015 - $start \) / 5 \) | sed -e's/$/;/'
cat <<HEREDOC
step=5;
index=count-1;
function update() {
HEREDOC
echo -n '	['
for city in $@; do echo -n '"'$city'",'; done | tr 'a-z' 'A-Z' |  sed -e's/,$/].forEach(function(city) {/'
echo ''
cat << HEREDOC
		document[city].src=(city.toLowerCase() + "/small/" + (start+step*index) + ".svg");
		document[city].title=start+step*index;
		document[city].alt=start+step*index + " map";
	});
}
function nextmap() {
	index=(index+1)%count;
	update();
}
function prevmap() {
	index=(index+count-1)%count;
	update();
}
function toggleshow(x) {
	if(document.getElementById(x).style.display=='inline-block') document.getElementById(x).style.display = 'none';
	else document.getElementById(x).style.display = 'inline-block';
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
<a href="northamerica.html">North American cities</a> -
<a href="europe.html">European cities</a> -
<a href="asia.html">East Asian cities</a> - 
<a href="other.html">Other cities</a>
<p>
<a href="javascript:prevmap()">five years earlier (or press a)</a> ---
<a href="javascript:nextmap()">five years later (or press s)</a>
<p>
HEREDOC

for city in $@; do
  NAME=`cat $city/name`
  UPPER=$(echo $city | tr 'a-z' 'A-Z')
  NATIVEW=$(grep ' width="' $city/small/2015.svg | head -n1 | sed -e's/.* width="\([0-9\.]*\)".*/\1/;')
  W=$(awk "BEGIN{print int(0.5+$NATIVEW*390/5376)}")
  H=$(awk "BEGIN{print int(0.5+$(grep ' height=' $city/small/2015.svg | head -n1 | sed -e's/.* height="\([0-9\.]*\)".*/\1/;')*$W/$NATIVEW)}")

  echo '<span id="'$UPPER'" style="display: inline-block; vertical-align: middle"><a href="'$city'">'$NAME'<br>' \
    | sed -e's!href="nyc"!href="../subtimeline/"!; s!href="chi"!href="../ltimeline"!; s!href="bos"!href="../ttimeline"!;'

  echo '  <img name="'$UPPER'" src="'$city'/small/2015.svg" title="2015" alt="2015 map" width="'$W'px" height="'$H'px" style="border-width: 1px; border-style: solid"></a></span>'
done

cat <<HEREDOC
<p>
<a href="javascript:prevmap()">five years earlier (or press a)</a> --- 
<a href="javascript:nextmap()">five years later (or press s)</a>
<p>
<form action="">Cities to show: 
HEREDOC
for city in $@; do
  NAME=`cat $city/name`
  UPPER=$(echo $city | tr 'a-z' 'A-Z')

  echo "<div style=\"display: inline-block\"><input type=\"checkbox\" id=\"${UPPER}checkbox\" onclick=\"toggleshow('$UPPER')\" checked><a href=\"$city\">$NAME</a></div>" \
    | sed -e's!href="nyc"!href="../subtimeline/"!; s!href="chi"!href="../ltimeline"!; s!href="bos"!href="../ttimeline"!;'

done

cat <<HEREDOC
</form>
<p>
Based on frequent midday service at the end of the year in question (<a href="notes.html">notes</a>).  Scale 10 CSS pixels per km.
<p>
Please send any corrections or questions to threestationsquare at gmail dot com.
<p>
<div id="preloader">
HEREDOC
for city in $@; do
  for year in `seq $start 5 2015`; do
    echo '<img src="'$city'/small/'$year'.svg" width="1" height="1" alt="">'
  done
done

cat <<HEREDOC
</div>
<font size="1">By <a href="/">Alexander Rapp</a> based on map data 
<a rel="license" href="http://creativecommons.org/licenses/by-sa/2.0/"><img alt="CC-BY-SA" style="border-width:0" src="http://i.creativecommons.org/l/by-sa/2.0/80x15.png"></a>
by <a href="http://www.openstreetmap.org">OpenStreetMap</a> contributors.</font>
</center>
</body></html>
HEREDOC


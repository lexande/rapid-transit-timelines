#!/bin/bash
cat <<HEREDOC
<!DOCTYPE HTML>
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
a:link.map-wrap {
        text-decoration: none;
}
span {
	margin-top: 5px;
	margin-bottom: 5px;
	vertical-align: middle;
}
.map {
	border: 1px solid;
	margin-left: 5px;
	margin-right: 5px;
}
body {
	text-align: center;
}
</style>
<script language="JavaScript" type="text/javascript">
HEREDOC
start=$(for city in $@; do ls $city/????.svg; done | sed -e's!^.../\(....\).svg!\1!' | sort | head -n 1)
echo "start=${start};"
echo -n "count="
expr 1 + \( \( 2015 - $start \) / 5 \) | sed -e's/$/;/'
echo -n "citystartyears = { "
for city in $@; do
  echo -n "${city}: "$(ls $city/????.svg | sed -e's!^.../\(....\).svg!\1!' | sort | head -n 1)", "
done
echo "};"
cat <<HEREDOC
step=5;
index=count-1;
function update() {
HEREDOC
echo -n '	['
for city in $@; do echo -n '"'$city'",'; done | tr 'a-z' 'A-Z' |  sed -e's/,$/].forEach(function(city) {/'
echo ''
cat << HEREDOC
		yr = start+step*index;
		mapimg = document.getElementById(city + "map");
		if (yr < citystartyears[city.toLowerCase()]) {
			if (mapimg.tagName.toUpperCase() == "IMG") {
				svgelt = document.createElementNS("http://www.w3.org/2000/svg", "svg");
				textelt = document.createElementNS("http://www.w3.org/2000/svg", "text");
				tspanelt = document.createElementNS("http://www.w3.org/2000/svg", "tspan");
				yearcontent = document.createTextNode(yr);
				tspanelt.appendChild(yearcontent);
				textelt.appendChild(tspanelt);
				textelt.setAttribute("x", "6.48935");
				textelt.setAttribute("y", "15.0139");
				textelt.setAttribute("style", "-inkscape-font-specification:Sans");
				textelt.setAttribute("font-family", "Sans");
				textelt.setAttribute("font-weight", "400");
				textelt.setAttribute("font-size", "10.4464px");
				svgelt.appendChild(textelt);
				svgelt.setAttribute("id", mapimg.id);
				svgelt.setAttribute("width", mapimg.width);
				svgelt.setAttribute("height", mapimg.height);
				svgelt.setAttribute("class", "map");
				svgelt.setAttribute("title", yr);
				svgelt.setAttribute("alt", yr + " map");
				mapimg.parentNode.replaceChild(svgelt, mapimg);
			} else {
				mapimg.getElementsByTagName("text")[0].getElementsByTagName("tspan")[0].innerHTML = yr;
				mapimg.setAttribute("title", yr);
				mapimg.setAttribute("alt", yr + " map");
			}
		} else {
			if (mapimg.tagName.toUpperCase() == "SVG") {
			console.log(city,yr);
				imgelt = document.createElement("img");
				imgelt.setAttribute("class", "map");
				imgelt.id = mapimg.getAttribute("id");
				imgelt.width = mapimg.getAttribute("width");
				imgelt.height = mapimg.getAttribute("height");
				imgelt.src = (city.toLowerCase() + "/small/" + (yr) + ".svg");
				imgelt.title = yr;
				imgelt.alt = yr + " map";
				mapimg.parentNode.replaceChild(imgelt, mapimg);
			} else {
				mapimg.src = (city.toLowerCase() + "/small/" + (yr) + ".svg");
				mapimg.title = yr;
				mapimg.alt = yr + " map";
			}
		}
	
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
<a href="javascript:" onclick="prevmap()">five years earlier (or press a)</a> ---
<a href="javascript:" onclick="nextmap()">five years later (or press s)</a>
<p>
HEREDOC

for city in $@; do
  NAME=`cat $city/name`
  UPPER=$(echo $city | tr 'a-z' 'A-Z')
  NATIVEW=$(grep ' width="' $city/small/2015.svg | head -n1 | sed -e's/.* width="\([0-9\.]*\)".*/\1/;')
  W=$(awk "BEGIN{print int(0.5+$NATIVEW*390/5376)}")
  H=$(awk "BEGIN{print int(0.5+$(grep ' height=' $city/small/2015.svg | head -n1 | sed -e's/.* height="\([0-9\.]*\)".*/\1/;')*$W/$NATIVEW)}")

  echo '<span id="'$UPPER'" style="display: inline-block;"><a href="'$city'">'$NAME'</a><br>' \
    | sed -e's!href="nyc"!href="../subtimeline/"!; s!href="bos"!href="../ttimeline"!;'

  echo '  <a href="'$city'" class="map-wrap"><img class="map" id="'$UPPER'map" src="'$city'/small/2015.svg" title="2015" alt="2015 map" width="'$W'px" height="'$H'px" style="border-width: 1px; border-style: solid"></a></span>' | sed -e's!href="nyc"!href="../subtimeline/"!; s!href="bos"!href="../ttimeline"!;'
done

cat <<HEREDOC
<p>
<a href="javascript:" onclick="prevmap()">five years earlier (or press a)</a> --- 
<a href="javascript:" onclick="nextmap()">five years later (or press s)</a>
<br>
<a id="animbutton" href="javascript:" onclick="startanim()">click here to animate</a>
<p>
<form action="">Cities to show: 
HEREDOC
for city in $@; do
  NAME=`cat $city/name`
  UPPER=$(echo $city | tr 'a-z' 'A-Z')

  echo "<div style=\"display: inline-block\"><input type=\"checkbox\" id=\"${UPPER}checkbox\" onclick=\"toggleshow('$UPPER')\" checked><a href=\"$city\">$NAME</a></div>" \
    | sed -e's!href="nyc"!href="../subtimeline/"!; s!href="bos"!href="../ttimeline"!;'

done

cat <<HEREDOC
</form>
<p>
Based on frequent midday service at the end of the year in question (<a href="notes.html">notes</a>).<br>
Scale: <svg width="100px" height="3px" style="vertical-align: middle; stroke-width: 0px; background-color: black;"/> = 10 km (10 CSS pixels per km)
<p>
Please send any corrections or questions to threestationsquare at gmail dot com.
<p>
<div id="preloader">
HEREDOC
for city in $@; do
  for img in ${city}/small/????.svg; do
    echo '<img src="'${img}'" width="1" height="1" alt="">'
  done
done

echo '</div>'
echo 'See also: <a href=".">rapid transit timelines around the world</a> -'
echo '<a href="misc">miscellaneous timelines and maps</a>'
cat ~/timelines/scripts/boilerplate/part4

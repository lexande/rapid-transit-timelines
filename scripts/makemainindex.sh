#!/bin/bash
cat <<HEREDOC
<!DOCTYPE HTML>
<html>
<head><title>Rapid Transit Timelines and Scale Comparison</title>
<meta http-equiv="Content-type" content="text/html;charset=UTF-8" />
<meta property="og:type" content="website" />
<meta property="og:title" content="Rapid Transit Timelines and Scale Comparison" />
<meta property="og:image" content="https://alexander.co.tz/timelines/preview.png" />
<meta property="og:description" content="Maps every 5 years, 1840-2020" />
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
a:link.map-wrap {
	text-decoration: none;
}
div#sidebar {
	float: left;
	background: #ffffff;
	border: 1px solid;
	width: 10.5em;
	max-height: calc(100% - 22px);
	top: 0;
	left: 0;
	margin: 5px;
	padding: 5px;
	position: fixed;
	display: flex;
	flex-flow: column;
	text-align: left;
}
div#form {
	flex: 1;
	overflow: auto;
}
div#button a:link {
	color: #000000;
	text-decoration: none;
}
div#button a:visited {
	color: #000000;
	text-decoration: none;
}
span {
	margin-top: 10px;
	margin-bottom: 10px;
	vertical-align: middle;
}
.map {
	border: 1px solid;
	margin-left: 10px;
	margin-right: 10px;
}
.headerfooter {
	padding-left: calc(10.5em + 22px);
	padding-right: calc(10.5em + 22px);
	white-space: nowrap;
}
body {
	text-align: center;
}
@media screen and (-ms-high-contrast: active), (-ms-high-contrast: none) {
	/* styles for IE since flex is broken */
	div#sidebar {
		line-height: 1.2em;
		display: block;
		max-height: calc(100% - 22px);
	}
	div#form {
		height: calc(100vh - 22px - 3.6em);
	}
}
</style>
<script type="text/javascript">
HEREDOC
start=$(for city in $@; do ls $city/????.svg; done | sed -e's!^.../\(....\).svg!\1!' | sort | head -n 1)
echo "start=${start};"
echo -n "count="
expr 1 + \( \( 2020 - $start \) / 5 \) | sed -e's/$/;/'
echo -n "citylist = ["
for city in $@; do echo -n '"'$city'",'; done | tr 'a-z' 'A-Z' | sed -e's/,$/];/'
echo ''
echo -n "citystartyears = { "
for city in $@; do
  echo -n "${city}: "$(ls $city/small/????.svg | sed -e's!^.../small/\(....\).svg!\1!' | sort | head -n 1)", "
done
echo "};"
echo -n "svgviewboxes = { "
for city in $@; do
  echo -n "${city}: \""$(if [ -d $city/uncropped ]; then grep viewBox $city/uncropped/2020.svg; else grep viewBox $city/2020.svg; fi | perl -wpe's/.*viewBox=".* .* ([0-9]*),? ([0-9]*)".*/$1 $2/')"\", "
done
echo "};"
cat <<HEREDOC
step=5;
index=count-1;
function update(city) {
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
			textelt.setAttribute("x", "89.4531");
			textelt.setAttribute("y", "206.9609");
			textelt.setAttribute("style", "-inkscape-font-specification:Sans");
			textelt.setAttribute("font-family", "Sans");
			textelt.setAttribute("font-weight", "400");
			textelt.setAttribute("font-size", "144px");
			svgelt.appendChild(textelt);
			svgelt.setAttribute("id", mapimg.id);
			svgelt.setAttribute("viewBox","0 0 " + svgviewboxes[city.toLowerCase()]);
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
}
function updateall() {
	citylist.forEach(function (city) {
		if (document.getElementById(city).style.display == "inline-block") {
			update(city);
		}
	});
}
function nextmap() {
	index = (index+1)%count;
	updateall();
}
function prevmap() {
	index = (index+count-1)%count;
	updateall();
}
function toggleshow(x) {
	span = document.getElementById(x);
	prediv = document.getElementById(x + "pre");
	if (span.style.display == 'inline-block') {
		mapimg = document.getElementById(x + "map");
		span.style.display = 'none';
		if (mapimg.tagName.toUpperCase() == "IMG") mapimg.src = "/0";
		imgs = prediv.getElementsByTagName("img");
		for (var i=0; i < imgs.length; i++) {
			prediv.removeChild(imgs[i]);
		}
	} else {
		update(x);
		for (var i = citystartyears[x.toLowerCase()]; i < start + count*step; i+=step) {
			img = document.createElement("img");
			img.src = x.toLowerCase() + '/small/' + i + '.svg';
			img.width = "1"; img.height = "1"; img.alt = "";
			prediv.appendChild(img);
		}
		span.style.display = 'inline-block';
	}
}
function toggleshowm(x) {
	span = document.getElementById(x);
	checkboxes = document.getElementsByClassName(x + "checkbox");
	if (span.style.display == 'inline-block') {
		for (var i=0; i < checkboxes.length; i++ ) { checkboxes[i].checked = false; }
	} else {
		for (var i=0; i < checkboxes.length; i++ ) { checkboxes[i].checked = true; }
	}
	toggleshow(x);
}
function togglesidebar() {
	f = document.getElementById("form");
	s = document.getElementById("showall");
	h = document.getElementById("hideall");
	a = document.getElementById("collapse");
	m = document.getElementById("maps");
	if (f.style.display == 'block') {
		f.style.display = 'none';
		s.style.display = 'none';
		h.style.display = 'none';
		a.innerHTML = "[+]";
		m.style.paddingLeft = "0";
	} else {
		f.style.display = 'block';
		s.style.display = 'block';
		h.style.display = 'block';
		a.innerHTML = "[&minus;]";
		m.style.paddingLeft = "calc(10.5em + 22px)";
	}
}
function selectall(i) {
	spans = document.getElementsByTagName("span");
	if (i < spans.length) {
		if (spans[i].style.display == 'none') {
			document.getElementById(spans[i].id + "checkbox").click();
		}
		setTimeout(function(){ selectall(i+1) }, 10);
	}
}
function deselectall() {
	spans = document.getElementsByTagName("span");
	for (var i=0; i < spans.length; i++) {
		if (spans[i].style.display == 'inline-block') {
			document.getElementById(spans[i].id + "checkbox").click();
		}
	}
}
function sidebarclick(x) {
	span = document.getElementById(x);
	if (span.style.display == 'none') {
		document.getElementById(x + "checkbox").click();
	}
	span.scrollIntoView();
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
<div class="headerfooter">
<h3>Rapid Transit Timelines and Scale Comparison</h3>
<a href="javascript:" onclick="prevmap()">five years earlier (or press a)</a> ---
<a href="javascript:" onclick="nextmap()">five years later (or press s)</a>
<br>
<a id="animbutton" href="javascript:" onclick="startanim()">click here to animate</a>
<br>
<small>(maps ordered by opening date; click a city name in sidebar to jump to its map)</small>
</div>
<br>
<div id="maps" style="padding-left: calc(10.5em + 22px);">
<noscript>Sorry, the maps really don't work without javascript.</noscript>
HEREDOC

for city in $@; do
  NAME=`cat $city/name`
  UPPER=$(echo $city | tr 'a-z' 'A-Z')
  NATIVEW=$(grep ' width="' $city/small/2020.svg | head -n1 | sed -e's/.* width="\([0-9\.]*\)".*/\1/;')
  W=$(awk "BEGIN{print int(0.5+$NATIVEW*10/138)}")
  H=$(awk "BEGIN{print int(0.5+$(grep ' height=' $city/small/2020.svg | head -n1 | sed -e's/.* height="\([0-9\.]*\)".*/\1/;')*$W/$NATIVEW)}")
  if [ -f $city/s ]; then
    echo '<span id="'$UPPER'" style="display: inline-block;"><a href="'$city'">'$NAME'</a><br>' \
    | sed -e's!href="nyc"!href="../subtimeline/"!; s!href="bos"!href="../ttimeline"!;'
    echo '  <a href="'$city'" class="map-wrap"><img class="map" id="'$UPPER'map" src="'$city'/small/2020.svg" title="2020" alt="2020 map" width="'${W}'" height="'${H}'"></a></span>' | sed -e's!href="nyc"!href="../subtimeline/"!; s!href="bos"!href="../ttimeline"!;'
  else
    echo '<span id="'$UPPER'" style="display: none;"><a href="'$city'">'$NAME'</a><br>' \
    | sed -e's!href="nyc"!href="../subtimeline/"!; s!href="bos"!href="../ttimeline"!;'
    echo '  <a href="'$city'" class="map-wrap"><img class="map" id="'$UPPER'map" src="/0" title="2020" alt="2020 map" width="'${W}'" height="'${H}'"></a></span>' | sed -e's!href="nyc"!href="../subtimeline/"!; s!href="bos"!href="../ttimeline"!;'
  fi
done

cat <<HEREDOC
</div>
<br>
<div class="headerfooter">
<a href="javascript:" onclick="prevmap()">five years earlier (or press a)</a> --- 
<a href="javascript:" onclick="nextmap()">five years later (or press s)</a>
</div>
<div id=sidebar>
<div id="button" style="position: absolute; right: 5px;" onclick="togglesidebar()"><a id="collapse" href="javascript:">[&minus;]</a></div>
<div style="padding-right: 2em;">Cities to show:</div>
<div id="form" style="display: block;">
HEREDOC
for city in $@; do
  perl -e'
    $city = $ARGV[0];
    $upper = $city;
    $upper =~ tr/a-z/A-Z/;
    $name = `cat $city/name`;
    $name =~ s/<br>/ /;
    chomp $name;
    if ( $name =~ / \/ / ) { 
      $id = "";
      foreach ( split(/ \/ /, $name) ) {
        if (-e "$city/s") {
          print "$_ <input type=\"checkbox\" id=\"${upper}checkbox${id}\" class=\"${upper}checkbox\" onclick=\"toggleshowm(\x27${upper}\x27)\" checked><a href=\"javascript:sidebarclick(\x27${upper}\x27)\">$_</a><br>\n";
        } else {
          print "$_ <input type=\"checkbox\" id=\"${upper}checkbox${id}\" class=\"${upper}checkbox\" onclick=\"toggleshowm(\x27${upper}\x27)\"><a href=\"javascript:sidebarclick(\x27${upper}\x27)\">$_</a><br>\n";
        }
      $id += 1;
      }
    } else {
      if (-e "$city/s") {
        print "$name <input type=\"checkbox\" id=\"${upper}checkbox${id}\" onclick=\"toggleshow(\x27${upper}\x27)\" checked><a href=\"javascript:sidebarclick(\x27${upper}\x27)\">${name}</a><br>\n";
      } else {
        print "$name <input type=\"checkbox\" id=\"${upper}checkbox${id}\" onclick=\"toggleshow(\x27${upper}\x27)\"><a href=\"javascript:sidebarclick(\x27${upper}\x27)\">${name}</a><br>\n";
      }
    }' $city
done | sort | sed -e's/.* <input/<input/;'
cat <<HEREDOC
</div>
<div id="showall" style="display: block;"><a href="javascript:selectall(0)">show all</a></div>
<div id="hideall" style="display: block;"><a href="javascript:deselectall()">hide all</a></div>
</div>
<br>
<div class="headerfooter">
<div style="white-space: normal;">
Based on frequent midday service at the end of the year in question (<a href="notes.html">notes</a>).<br>
Scale: <svg width="100px" height="3px" style="vertical-align: middle; stroke-width: 0px; background-color: black;"/> = 10 km (10 CSS pixels per km)</div>
<p>
Please send any corrections or questions to threestationsquare at gmail dot com.
<p>
See also: <a href="misc">miscellaneous timelines and maps</a>
<div style="font-size: x-small;">By <a href="/">Alexander Rapp</a> based on map data 
<a rel="license" href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>
by <a href="http://www.openstreetmap.org">OpenStreetMap</a> contributors and historical sources.</div>
</div>
<div id=preloader>
HEREDOC
for city in $@; do
  UPPER=`echo $city | tr 'a-z' 'A-Z'`
  echo '<div id="'$UPPER'pre">'
  if [ -f $city/s ]; then
    for yr in $(seq ${start} 5 2020); do
      if [ -f $city/small/$yr.svg ]; then
        echo '<img src="'${city}'/small/'${yr}'.svg" width="1" height="1" alt="">'
      fi
    done
  fi
  echo '</div>'
done
echo '</div><script type="text/javascript">'
echo -n '['
for city in $@; do echo -n '"'$city'",'; done | tr 'a-z' 'A-Z' | sed -e's/,$/].forEach(function(city) {/'
cat <<HEREDOC
	if ((document.getElementById(city + "checkbox").checked && document.getElementById(city).style.display == "none") || (!document.getElementById(city + "checkbox").checked && document.getElementById(city).style.display == "inline-block")) {
		toggleshow(city);
	}
});
</script></body></html>
HEREDOC

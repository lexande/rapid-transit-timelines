cat <<HEREDOC
<!DOCTYPE HTML>
<html>
<head><title>Streetcar Scale Comparison</title>
<style type="text/css">
span {
	margin-top: 10px;
	margin-bottom: 10px;
}
.map {
	border: 1px solid;
	margin-left: 10px;
	margin-right: 10px;
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
<script language="JavaScript" type="text/javascript">
function toggleshow(x) {
	if(document.getElementById(x).style.display=='inline-block') document.getElementById(x).style.display = 'none';
	else document.getElementById(x).style.display = 'inline-block';
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
function sidebarclick(x) {
	span = document.getElementById(x);
	if (span.style.display == 'none') {
		document.getElementById(x + "checkbox").click();
	}
	span.scrollIntoView();
}
function selectall() {
	spans = document.getElementsByTagName("span");
	for (var i=0; i < spans.length; i++) {
		if (spans[i].style.display == 'none') {
			document.getElementById(spans[i].id + "checkbox").click();
		}
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
<meta http-equiv="Content-type" content="text/html;charset=UTF-8">
<center>
<h3>Streetcar Scale Comparison</h3>
<div id="maps" style="padding-left: calc(10.5em + 22px);">
HEREDOC
CITIES=$(for file in $@; do grep ^`basename $file .svg` names | sed -e's/<br>/ /; s/ (.*//; s/\(.*\)@*\t\(.*\)/\2 \1/;'; done | sort | sed -e's/.* //; s/@//;')
for city in $CITIES; do
  NAME=`grep ^$city names | sed -e's/.*\t//'`
  SNAME=`echo $NAME | sed -e's/<br>/ /; s/ (.*//;'`
  UPPER=$(echo $city | tr 'a-z' 'A-Z')
  NATIVEW=$(grep '^   width="' ${city}.svg | head -n1 | sed -e's/.* width="\([0-9\.]*\)".*/\1/;')
  W=$(awk "BEGIN{print int(0.5+$NATIVEW*30/138)}")
  H=$(awk "BEGIN{print int(0.5+$(grep ' height=' ${city}.svg | head -n1 | sed -e's/.* height="\([0-9\.]*\)".*/\1/;')*$W/$NATIVEW)}")
  if ( grep ^$city@ names >/dev/null); then
    echo '<span id="'$UPPER'" style="display: inline-block; vertical-align: middle">'$NAME'<br>'
  else
    echo '<span id="'$UPPER'" style="display: none; vertical-align: middle">'$NAME'<br>'
  fi
  echo '  <img class="map" src="'${city}.svg'" title="'$SNAME'" alt="'$SNAME' map" width="'$W'px" height="'$H'px"></span>'
done
cat <<HEREDOC
<div id="sidebar">
<div id="button" style="position: absolute; right: 5px;" onclick="togglesidebar()"><a id="collapse" href="javascript:">[&minus;]</a></div>
<div style="padding-right: 2em;">Cities to show:</div>
<div id="form" style="display: block;">
HEREDOC
for city in $CITIES; do
  perl -e'
    $city = $ARGV[0];
    $upper = $city;
    $upper =~ tr/a-z/A-Z/;
    $name = `grep ^$city names`;
    $name =~ s/<br>/ /;
    $name =~ s/ \(.*//;
    $show = ($name =~ /@/);
    $name =~ s/^.*\t//;
    chomp $name;
    if ( $name =~ / \/ / ) { 
      $id = "";
      foreach ( split(/ \/ /, $name) ) {
	if ($show) {
	  print "$_ <input type=\"checkbox\" id=\"${upper}checkbox${id}\" class=\"${upper}checkbox\" onclick=\"toggleshowm(\x27${upper}\x27)\" checked><a href=\"javascript:sidebarclick(\x27${upper}\x27)\">$_</a><br>\n";
	} else {
	  print "$_ <input type=\"checkbox\" id=\"${upper}checkbox${id}\" class=\"${upper}checkbox\" onclick=\"toggleshowm(\x27${upper}\x27)\"><a href=\"javascript:sidebarclick(\x27${upper}\x27)\">$_</a><br>\n";
	}
      $id += 1;
      }
    } else {
      if ($show) {
	print "$name <input type=\"checkbox\" id=\"${upper}checkbox${id}\" onclick=\"toggleshow(\x27${upper}\x27)\" checked><a href=\"javascript:sidebarclick(\x27${upper}\x27)\">${name}</a><br>\n";
      } else {
	print "$name <input type=\"checkbox\" id=\"${upper}checkbox${id}\" onclick=\"toggleshow(\x27${upper}\x27)\"><a href=\"javascript:sidebarclick(\x27${upper}\x27)\">${name}</a><br>\n";
      }
    }' $city
done | sort | sed -e's/.* <input/<input/;'
cat <<HEREDOC
</div>
<div id="showall" style="display: block;"><a href="javascript:selectall()">show all</a></div>
<div id="hideall" style="display: blcok;"><a href="javascript:deselectall()">hide all</a></div>
</div>
<br>
<div class="headerfooter">
<div style="white-space: normal;">
Thick lines represent running in streets or with uncontrolled or light-controlled grade crossings; thin lines are sections with grade-separations or crossing gates.  Connecting rapid transit lines are shown in light gray, ferries in cyan.  All lines shown run at least every 20 minutes during the day on weekdays.  Maps current as of 2019.<br>
Scale: <svg width="300px" height="3px" style="vertical-align: middle; stroke-width: 0px; background-color: black;"/> = 10 km (30 CSS pixels per km)
<p>
Please send any corrections or questions to threestationsquare at gmail dot com.
<p>
See also: <a href="/timelines">rapid transit timelines</a> - <a href="/timelines/misc/">miscellaneous timelines and maps</a>
</div>
HEREDOC
cat ~/timelines/scripts/boilerplate/part4

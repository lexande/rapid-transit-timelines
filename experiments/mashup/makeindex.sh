cat <<HEREDOC
<!DOCTYPE HTML>
<html>
<head><title>Ancient Walled City & Modern Rapid Transit Scale Comparison</title>
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
</style>
<script language="JavaScript" type="text/javascript">
function toggleshow(x) {
	if(document.getElementById(x).style.display=='inline-block') document.getElementById(x).style.display = 'none';
	else document.getElementById(x).style.display = 'inline-block';
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
<h3>Ancient Walled City & Modern Rapid Transit Scale Comparison</h3>
HEREDOC
for file in $@; do
  city=`basename $file .svg`
  NAME=`grep ^$city names | sed -e's/.*\t//'`
  SNAME=`echo $NAME | sed -e's/<br>.*//; s/,//'`
  UPPER=$(echo $city | tr 'a-z' 'A-Z')
  NATIVEW=$(grep '^   width="' $file | head -n1 | sed -e's/.* width="\([0-9\.]*\)".*/\1/;')
  W=$(awk "BEGIN{print int(0.5+$NATIVEW*0.6)}")
  H=$(awk "BEGIN{print int(0.5+$(grep ' height=' $file | head -n1 | sed -e's/.* height="\([0-9\.]*\)".*/\1/;')*$W/$NATIVEW)}")
  echo '<span id="'$UPPER'" style="display: inline-block; vertical-align: middle">'$NAME'<br>'
  echo '  <img class="map" src="'$file'" title="'$SNAME'" alt="'$SNAME' map" width="'$W'px" height="'$H'px"></span>'
done
echo '<p>'
echo '<form action="">Cities to show:'
for file in $@; do
  city=`basename $file .svg`
  NAME=`grep ^$city names | sed -e's/.*\t//; s/<br>.*//; s/,//;'`
  UPPER=$(echo $city | tr 'a-z' 'A-Z')
  echo "<div style=\"display: inline-block\"><input type=\"checkbox\" id=\"${UPPER}checkbox\" onclick=\"toggleshow('$UPPER')\" checked>$NAME</div>"
done
cat <<HEREDOC
</form>
<a href="javascript:selectall()">show all</a>
<a href="javascript:deselectall()">hide all</a>
<p>
Scale: <svg width="60px" height="3px" style="vertical-align: middle; stroke-width: 0px; background-color: black;"/> = 1 km (60 CSS pixels per km)
<p>
Population estimates extremely approximate.  Please send any corrections or questions to threestationsquare at gmail dot com.
<p>
See also: <a href="/timelines">rapid transit timelines</a> - <a href="/walledcityscale">ancient walled city scale comparison</a> - <a href="/timelines/misc/">miscellaneous timelines and maps</a>
<p>
<div style="font-size: x-small;">By <a href="/">Alexander Rapp</a> (<a rel="license" href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>) based on map data by <a href="http://www.openstreetmap.org">OpenStreetMap</a> and Wikimedia
HEREDOC
echo -n '('
i=1
for src in `cat sources`; do
  echo -n '<a href="'$src'">'$i'</a>,'
  i=`expr $i + 1`
done | sed -e's!,$!) contributors and historical sources.</div></body></html>!'
echo ''

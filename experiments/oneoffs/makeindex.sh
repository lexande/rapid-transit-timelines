SCALE=$1
shift
cat <<HEREDOC
<!DOCTYPE HTML>
<html>
<head><title>One-off Rapid Transit Map Scale Comparison</title>
<style type="text/css">
span {
        margin-top: 5px;
        margin-bottom: 5px;
}
.map {
        border: 1px solid;
        margin-left: 5px;
        margin-right: 5px;
}
</style>
<script language="JavaScript" type="text/javascript">
function toggleshow(x) {
	if(document.getElementById(x).style.display=='inline-block') document.getElementById(x).style.display = 'none';
	else document.getElementById(x).style.display = 'inline-block';
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
<h3>One-off Rapid Transit Maps for Scale Comparison with <a href="/timelines">Timelines</a></h3>
HEREDOC
for file in $@; do
  city=`basename $file .svg`
  NAME=`grep ^$city names | sed -e's/.*\t//'`
  SNAME=`echo $NAME | sed -e's/<br>.*//'`
  UPPER=$(echo $city | tr 'a-z' 'A-Z')
  NATIVEW=$(grep '^   width="' $file | head -n1 | sed -e's/.* width="\([0-9\.]*\)".*/\1/;')
  W=$(awk "BEGIN{print int(0.5+$NATIVEW*$SCALE/5376)}")
  H=$(awk "BEGIN{print int(0.5+$(grep ' height=' $file | head -n1 | sed -e's/.* height="\([0-9\.]*\)".*/\1/;')*$W/$NATIVEW)}")
  echo '<span id="'$UPPER'" style="display: inline-block; vertical-align: middle">'$NAME'<br>'
  echo '  <img class="map" src="'$file'" title="'$SNAME'" alt="'$SNAME' map" width="'$W'px" height="'$H'px"></span>'
done
echo '<p>'
echo '<!--<form action="">Cities to show:'
for file in $@; do
  city=`basename $file .svg`
  NAME=`grep ^$city names | sed -e's/.*\t//'`
  UPPER=$(echo $city | tr 'a-z' 'A-Z')
  echo "<div style=\"display: inline-block\"><input type=\"checkbox\" id=\"${UPPER}checkbox\" onclick=\"toggleshow('$UPPER')\" checked>$NAME</div>"
done
if [ $SCALE = 390 ]; then
  cat <<HEREDOC
</form>-->
<a href="large.html">larger versions</a>
<p>
Based on frequent midday service at the end of the year in question (<a href="notes.html">notes</a>).<br>
Scale: <svg width="100px" height="3px" style="vertical-align: middle; stroke-width: 0px; background-color: black;"/> = 10 km (10 CSS pixels per km)
<p>
Please send any corrections or questions to threestationsquare at gmail dot com.
<p>
See also: <a href="/timelines">rapid transit timelines</a> - <a href="/timelines/misc/">miscellaneous timelines and maps</a>
HEREDOC
elif [ $SCALE = 1169 ]; then
  cat <<HEREDOC
</form>-->
<a href=".">smaller versions</a>
<p>
Based on frequent midday service at the end of the year in question (<a href="notes.html">notes</a>).<br>
Scale: <svg width="300px" height="3px" style="vertical-align: middle; stroke-width: 0px; background-color: black;"/> = 10 km (30 CSS pixels per km)
<p>
Please send any corrections or questions to threestationsquare at gmail dot com.
<p>
See also: <a href="/timelines">rapid transit timelines</a> - <a href="/timelines/misc/">miscellaneous timelines and maps</a>
HEREDOC
fi
cat ~/timelines/scripts/boilerplate/part4

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
  UPPER=$(echo $city | tr 'a-z' 'A-Z')
  NATIVEW=$(grep '^   width="' $file | head -n1 | sed -e's/.* width="\([0-9\.]*\)".*/\1/;')
  W=$(awk "BEGIN{print int(0.5+$NATIVEW*390/5376)}")
  H=$(awk "BEGIN{print int(0.5+$(grep ' height=' $file | head -n1 | sed -e's/.* height="\([0-9\.]*\)".*/\1/;')*$W/$NATIVEW)}")
  echo '<span id="'$UPPER'" style="display: inline-block; vertical-align: middle">'$NAME'<br>'
  echo '  <img class="map" src="'$file'" title="'$NAME'" alt="'$NAME' map" width="'$W'px" height="'$H'px"></span>'
done
echo '<p>'
echo '<!--<form action="">Cities to show:'
for file in $@; do
  city=`basename $file .svg`
  NAME=`grep ^$city names | sed -e's/.*\t//'`
  UPPER=$(echo $city | tr 'a-z' 'A-Z')
  echo "<div style=\"display: inline-block\"><input type=\"checkbox\" id=\"${UPPER}checkbox\" onclick=\"toggleshow('$UPPER')\" checked>$NAME</div>"
done
cat <<HEREDOC
</form>-->
<p>
Based on frequent midday service at the end of the year in question (<a href="notes.html">notes</a>).  Scale 10 CSS pixels per km.
<p>
Please send any corrections or questions to threestationsquare at gmail dot com.
<p>
See also: <a href="/timelines">rapid transit timelines</a> - <a href="/timelines/misc/">miscellaneous timelines and maps</a>
HEREDOC
cat ~/timelines/scripts/boilerplate/part4

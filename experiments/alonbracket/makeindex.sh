cat <<HEREDOC
<!DOCTYPE HTML>
<html>
<head><title>Rapid Transit Bracket: Round of NNN</title>
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
function listclick(x) {
	span = document.getElementById(x);
	if (span.style.display == 'none') {
		document.getElementById(x + "checkbox").click();
	}
	span.scrollIntoView();
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
<h3>Rapid Transit Bracket: Round of NNN</h3>
HEREDOC
n=0
for file in $@; do if [ -f $file ]; then
  city=`basename $file .svg`
  if [ $city = szx ]; then NAME="Shenzhen"; elif [ $city = hkg ]; then NAME="Hong Kong"; else NAME=`cat ~/timelines/timelines/$city/name`; fi
  SNAME=`echo $NAME | sed -e's/<br>/ /; s/ (.*//;'`
  UPPER=$(echo $city | tr 'a-z' 'A-Z')
  NATIVEW=$(grep '^   width="' $file | head -n1 | sed -e's/.* width="\([0-9\.]*\)".*/\1/;')
  W=$(awk "BEGIN{print int(0.5+$NATIVEW*10/138)}")
  H=$(awk "BEGIN{print int(0.5+$(grep ' height=' $file | head -n1 | sed -e's/.* height="\([0-9\.]*\)".*/\1/;')*$W/$NATIVEW)}")
  echo '<span id="'$UPPER'" style="display: inline-block; vertical-align: middle">'$NAME'<br>'
  echo '  <img class="map" src="'$file'" title="'$SNAME'" alt="'$SNAME' map" width="'$W'px" height="'$H'px"></span>'
  if [ $n = 1 ]; then
    echo '<br>'
    n=0
  else
    n=1
  fi
else hed=$(echo $file | tr _ ' '); echo '<h4>'$hed'</h4>'; fi; done
#echo '<p>'
#echo '<form action="">Cities to show:'
#for file in $@; do
#  city=`basename $file .svg`
#  NAME=`cat ~/timelines/timelines/$city/name`
#  UPPER=$(echo $city | tr 'a-z' 'A-Z')
#  echo "<div style=\"display: inline-block\"><input type=\"checkbox\" id=\"${UPPER}checkbox\" onclick=\"toggleshow('$UPPER')\" checked><a href=\"javascript:listclick('$UPPER')\">$NAME</a></div>"
#done
cat <<HEREDOC
</form>
<p>
Based on frequent midday service (<a href="../../timelines/notes.html">notes</a>). Current as of August 2019.<br>
Scale: <svg width="100px" height="3px" style="vertical-align: middle; stroke-width: 0px; background-color: black;"/> = 10 km (10 CSS pixels per km)
<p>
See also: <a href="/timelines">rapid transit timelines</a> - <a href="/timelines/misc/">miscellaneous timelines and maps</a>
HEREDOC
cat ~/timelines/scripts/boilerplate/part4

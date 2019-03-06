SCALE=$1
shift
cat <<HEREDOC
<!DOCTYPE HTML>
<html>
<head><title>Unrealised Rapid Transit Plans</title>
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
posdict = {};
function setsrc(x, url, pos) {
        document.getElementById(x + "map").src = url;
	posdict[x] = pos;
}
function next(x) {
	if (!(x in posdict)) { posdict[x] = 0; }
	var links = document.getElementById(x).getElementsByClassName('setsrc');
        if (posdict[x] + 1 >= links.length) {
		links[0].click();
	} else {
		links[posdict[x]+1].click();
	}
}
window.onload=function() {
	var spans = document.getElementsByTagName('span');
	for (var i=0; i<spans.length; i++) {
		if (document.getElementById(spans[i].id).getElementsByClassName('setsrc')[0].innerHTML.match(/actual/)) {
			next(spans[i].id);
		}
	}
}
document.onkeydown=function(keypress) {
        if(keypress.which == 65) {
		var spans = document.getElementsByTagName('span');
		for (var i=0; i<spans.length; i++) {
			var links = document.getElementById(spans[i].id).getElementsByClassName('setsrc');
			if (!(spans[i].id in posdict)) { posdict[spans[i].id] = 0; }
        		if (posdict[spans[i].id] - 1 < 0) {
				links[posdict[spans[i].id] - 1 + links.length].click();
			} else {
				links[posdict[spans[i].id] - 1].click();
			}
		}
	}
        if(keypress.which == 83) {
		var spans = document.getElementsByTagName('span');
		for (var i=0; i<spans.length; i++) {
			next(spans[i].id);
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
<h3>Unrealised Rapid Transit Plans</h3>
HEREDOC
oldcity=""
for file in $@; do
  if [ -f $file ]; then
    city=`grep ^$file names | awk -F"\t" '{print $2}'`
    NAME=`grep ^$file names | awk -F"\t" '{print $3}'`
    SUBNAME=`grep ^$file names | awk -F"\t" '{print $4}'`
    URL=`grep ^$file names | awk -F"\t" '{print $5}'`
    if [ c$city != c$oldcity ]; then
      altfile=$(echo $file | sed -e's!small/!!')
      NATIVEW=$(grep '^   width="' $altfile | head -n1 | sed -e's/.* width="\([0-9\.]*\)".*/\1/;')
      W=$(awk "BEGIN{print int(0.5+$NATIVEW*$SCALE/5376)}")
      H=$(awk "BEGIN{print int(0.5+$(grep ' height=' $altfile | head -n1 | sed -e's/.* height="\([0-9\.]*\)".*/\1/;')*$W/$NATIVEW)}")
      index=0
      if [ ! -z $oldcity ]; then
        echo "</small></span>"
      fi
      echo '<span id="'$city'" style="display: inline-block; vertical-align: middle">'$NAME'<br>'
      echo '<a href="javascript:next('\'$city\'');">'
      echo '<img class="map" src="'$file'" id="'$city'map" title="'$NAME'" alt="'$SNAME' map" width="'$W'px" height="'$H'px"></a><small>'
    fi
    echo -n '<br><a class="setsrc" href="javascript:setsrc('\'$city\'','\'$file\'','$index');">'$SUBNAME'</a>'
    if [ ! -z "$URL" ]; then
      echo ' (<a href="'$URL'">info</a>)'
    else
      echo ''
    fi
    oldcity=$city
    index=$(expr $index + 1)
  else
    if [ ! -z $oldcity ]; then
      echo "</small></span>"
    fi
    echo $file
  fi
done
echo '</small></span><p>'
if [ $SCALE = 390 ]; then
  cat <<HEREDOC
<a href="large.html">larger versions</a>
<p>
Based on planned frequent midday service (<a href="notes.html">notes</a>).<br>
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
Based on planned frequent midday service (<a href="notes.html">notes</a>).<br>
Scale: <svg width="300px" height="3px" style="vertical-align: middle; stroke-width: 0px; background-color: black;"/> = 10 km (30 CSS pixels per km)
<p>
Please send any corrections or questions to threestationsquare at gmail dot com.
<p>
See also: <a href="/timelines">rapid transit timelines</a> - <a href="/timelines/misc/">miscellaneous timelines and maps</a>
HEREDOC
fi
cat ~/timelines/scripts/boilerplate/part4

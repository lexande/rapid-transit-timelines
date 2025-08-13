#!/usr/bin/perl -wp

BEGIN {
    $dleft = shift;
    $dtop = shift;
    $dright = shift;
    $dbottom = shift;
    $left = $top = $width = $height = $tspanl = $tspanr = $tspant = $tspanb = $viewboxseen = 0;
    $newleft = $newtop = $newwidth = $newheight = $newtspanl = $newtspanr = $newtspant = $newtspanb = 0;
}

if (!$viewboxseen && / width="([0-9]+)"/) {
    $width = $1;
    $newwidth = $width - $dleft + $dright;
}

if (!$viewboxseen && / height="([0-9]+)"/) {
    $height = $1;
    $newheight = $height - $dtop + $dbottom;
}

if (/viewBox="(-?[0-9]+),? (-?[0-9]+),? ([0-9]+),? ([0-9]+),?"/) {
    $left = $1;
    $top = $2;
    $width = $3;
    $height = $4;
    $tspanl = $left + 89.45;
    $tspanr = $left + $width - 422.55;
    $tspant = $top + 206.96;
    $tspanb = $top + $height - 102.04;
    $newwidth = $width - $dleft + $dright;
    $newheight = $height - $dtop + $dbottom;
    $newleft = $left + $dleft;
    $newtop = $top + $dtop;
    $newtspanl = $newleft + 89.45;
    $newtspanr = $newleft + $newwidth - 422.55;
    $newtspant = $newtop + 206.96;
    $newtspanb = $newtop + $newheight - 102.04;
    $viewboxseen = 1;
}

s/viewBox=".*"/viewBox="$newleft $newtop $newwidth $newheight"/;
s/width="$width"/width="$newwidth"/;
s/height="$height"/height="$newheight"/;
s/x="$tspanl"/x="$newtspanl"/;
s/x="$tspanr"/x="$newtspanr"/;
s/y="$tspant"/y="$newtspant"/;
s/y="$tspanb"/y="$newtspanb"/;

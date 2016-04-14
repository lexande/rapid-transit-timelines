#!/usr/bin/perl -wi

$b = 1;
while (<>) {
  if (/^   width="(.*)"/) {
    $w=$1;
  } elsif (/^   height="(.*)"/) {
    $h = $1;
  }
  if ($h and $w and $b) {
    s/\n/\n   viewBox="0, 0, $w, $h"\n/;
    $b=0;
  }
  print;
} 

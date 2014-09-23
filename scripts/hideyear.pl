#!/usr/bin/perl -wp
BEGIN {
    $state = 0;
}
if (/tspan1/) {
    $state = 1;
} elsif (/tspan2/) {
    $state = 2;
}
if ($state == 2) {
   s!>.*</tspan>!></tspan>!;
}

#!/usr/bin/perl -wp
BEGIN {
    $state = 0;
}
if (/<text/ && $state == 0) {
    $state = 1;
} elsif (/<text/) {
    $state = 2;
}
if ($state == 1) {
   s!2577.45!-60.55!;
}

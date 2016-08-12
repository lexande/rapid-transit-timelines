#!/usr/bin/perl

open MAP, $ARGV[0] or die $!;

$notpath=1;
while (<MAP>) {
	s/2015/$ARGV[1]/;
	if (/<path/) { $notpath=0; }
	if ($notpath) { print $_; }
	if (m!/>!) { $notpath=1; }
}

close MAP;

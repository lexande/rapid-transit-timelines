#!/usr/bin/perl

open MAP, "2010.svg" or die $!;
open BLANKMAP, ">", $ARGV[0] . ".svg" or die $!;

$notpath=1;
while (<MAP>) {
	s/2010/$1/;
	if (/<path/) { $notpath=0; }
	if ($notpath) { print BLANKMAP $_; }
	if (m!/>!) { $notpath=1; }
}

close MAP; close BLANKMAP;

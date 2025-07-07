#!/usr/bin/perl -w

open(my $correctfile, "<", $ARGV[0]) or die $!;

my ($x, $y, $height, $width);
my $inimage = 0;

while(<$correctfile>) {
    if (/<image/) {
        $inimage = 1;
    }
    if ($inimage && /x="(-?[0-9\.]+)"/) {
        $x = $1;
    }
    if ($inimage && /y="(-?[0-9\.]+)"/) {
        $y = $1;
    }
    if ($inimage && /height="(-?[0-9\.]+)"/) {
        $height = $1;
    }
    if ($inimage && /width="(-?[0-9\.]+)"/) {
        $width = $1;
    }
    if ($inimage && />/ && !/<image/) {
        $inimage = 0;
    }
}

close $correctfile;

$fixedfilestring = '';
open(my $wrongfile, "<", $ARGV[1]) or die $!;

while(<$wrongfile>) {
    if (/<image/) {
        $inimage = 1;
    }
    if ($inimage && /x="(-?[0-9\.]+)"/) {
        s/$1/$x/;
    }
    if ($inimage && /y="(-?[0-9\.]+)"/) {
        s/$1/$y/;
    }
    if ($inimage && /height="(-?[0-9\.]+)"/) {
        s/$1/$height/;
    }
    if ($inimage && /width="(-?[0-9\.]+)"/) {
        s/$1/$width/;
    }
    if ($inimage && />/ && !/<image/) {
        $inimage = 0;
    }
    $fixedfilestring .= $_;
}

close $wrongfile;
open($wrongfile, ">", $ARGV[1]);
print $wrongfile $fixedfilestring;

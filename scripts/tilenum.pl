#!/usr/bin/perl

use Math::Trig;
$lat = shift;
$lon = shift;
$zoom = 14;
my $xtile = int( ($lon+180)/360 * 2**$zoom ) ;
my $ytile = int( (1 - log(tan(deg2rad($lat)) + sec(deg2rad($lat)))/pi)/2 * 2**$zoom ) ;
print "$xtile $ytile\n";


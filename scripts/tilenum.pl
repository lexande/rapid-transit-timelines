#!/usr/bin/perl

use Math::Trig;
if ($#ARGV > 0) { $zoom = shift; } else { $zoom = 14; }
@latlong = split("/",shift);
$lat = $latlong[0];
$lon = $latlong[1];
my $xtile = int( ($lon+180)/360 * 2**$zoom ) ;
my $ytile = int( (1 - log(tan(deg2rad($lat)) + sec(deg2rad($lat)))/pi)/2 * 2**$zoom ) ;
print "$xtile $ytile\n";


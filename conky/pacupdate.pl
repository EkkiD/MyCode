#!/usr/bin/perl
#based on the conky config posted by Foucault on the Arch Linux forums
use strict;
use warnings;
my $n = `pacman -Qu | wc -l`;
my $cool = "88CC00";
my $medi = "DDDD00";
my $hot = "EE5500";

chomp($n);
if ($n eq "0"){ print '${color '."$cool".'}OK${color}' }
else{ print '${color '."$hot".'}'."$n new".'${color}' }

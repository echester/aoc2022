#!/usr/bin/perl
#
# aoc2022-04-v2
#
# advent of code 2022 | ed chester | @bocs@twt.cymru
# day 4
# part 1 & 2 - Camp Cleanup
#
# "One of those that looks so easy in part 1, that you're designing a multi-depth hash
# for part 2 from the get-go just in case. Turns out it wasn't needed either."
#
# v2 refactored later in day to create the isRangeSubset() function. that function in 
# turn should be refactored to return the extent of the overlap, but that's not happening
# today. or possibly ever.
#

use strict;
use warnings;
use lib '../';
use aoc qw| isRangeSubset |;

my $infile = (defined $ARGV[0]) ? $ARGV[0] : 'input.dat';
open (my $inf, '<', $infile) || die "$!\n";
my ($contained, $overlaps) = (0, 0);

while(<$inf>) {
	next unless /(\d+)-(\d+),(\d+)-(\d+)/;
	if 	(isRangeSubset($1, $2, $3, $4) == 0) 	{ $contained++; $overlaps++; }
	elsif (isRangeSubset($1, $2, $3, $4) > 0) 	{ $overlaps++; }
}

printf "Part 1 = %d\n", $contained;
printf "Part 2 = %d\n", $overlaps;

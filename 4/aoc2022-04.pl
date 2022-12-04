#!/usr/bin/perl
#
# aoc2022-04
#
# advent of code 2022 | ed chester | @bocs@twt.cymru
# day 4
# part 1 & 2 - Camp Cleanup
#
# "One of those that looks so easy in part 1, that you're designing a multi-depth hash
# for part 2 from the get-go just in case. Turns out it wasn't needed either."
#

use strict;
use warnings;

my $infile = (defined $ARGV[0]) ? $ARGV[0] : 'input.dat';
my ($contained, $overlaps) = (0, 0);

open (INF, '<', $infile) || die "$!\n";

while(<INF>) {
	chomp;
	next unless /(\d+)-(\d+),(\d+)-(\d+)/;
	my ($fl, $fu, $sl, $su) = ($1, $2, $3, $4);

	# part 1
	if (
		(($fl >= $sl) && ($fu <= $su)) ||
		(($sl >= $fl) && ($su <= $fu))
		) {
		$contained++;
	}

	# part 2
	unless (
		($fu < $sl) ||
		($su < $fl)
		) {
		$overlaps++;
	}
}

close INF;
printf "Part 1 = %d\n", $contained;
printf "Part 2 = %d\n", $overlaps;

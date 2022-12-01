#!/usr/bin/perl
#
# aoc2022-01
#
# advent of code 2022 
# day 1
# part 1 & 2
#
# "it's easy to be enthusiastic at this point."
# 
# massive props to Eric W for another year of near-insanity in the 
# pursuit of superior code skillz.
#

use strict;
use warnings;
use List::Util qw| max sum | ;

my $infile = (defined $ARGV[0]) ? $ARGV[0] : 'input.dat';

my @elves;
my ($elfnum, $cals) = (0, 0);

open (INF, '<', $infile) || die "$!\n";

while(<INF>) {
	chomp;
	if (length) { $cals += $_; next; }
	$elves[$elfnum] = $cals; 
	$cals = 0; 
	$elfnum++; 
}
close INF;

printf "Max. elf cals\t= %d\n", max(@elves);
@elves = sort { $a <=> $b } @elves;
printf "Max. of top 3\t= %d\n", sum(@elves[-3..-1]);

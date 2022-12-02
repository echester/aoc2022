#!/usr/bin/perl
#
# aoc2022-02
#
# advent of code 2022 | ed chester | @bocs@twt.cymru
# day 2
# part 1 & 2
#
# "It always starts deceptively easily. 'I can do this!' you may 
# think, and you'll be right, for a while. How long for wholly 
# depends on whether you have a real job, the school run, or 
# simply - enough sleep to function properly."
# 

use strict;
use warnings;

my $infile = (defined $ARGV[0]) ? $ARGV[0] : 'input.dat';

# assign each combination of input a score value based on win/lose and move played:
# part 1 values
my %s1 = ('AX', 4, 'AY', 8, 'AZ', 3, 'BX', 1, 'BY', 5, 'BZ', 9, 'CX', 7, 'CY', 2, 'CZ', 6);
# modified for part 2:
my %s2 = ('AX', 3, 'AY', 4, 'AZ', 8, 'BX', 1, 'BY', 5, 'BZ', 9, 'CX', 2, 'CY', 6, 'CZ', 7);

# init total scores for part 1 and part 2
my ($t1, $t2) = (0, 0);

# go!
open (INF, '<', $infile) || die "$!\n";
while(<INF>) {
	chomp;
	next unless length;
	s/ //g;
	$t1 += $s1{$_};
	$t2 += $s2{$_};
}
close INF;

printf "Part 1 score = %d\n", $t1;
printf "Part 2 score = %d\n", $t2;

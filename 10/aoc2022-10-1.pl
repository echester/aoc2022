#!/usr/bin/perl
#
# aoc2022-10-1
#
# advent of code 2022 | ed chester | @bocs@twt.cymru
# day 10 part 1
#
# "the ringing of horrendous, cracked bells of memory
# as they bash against the broken screen of inscrutible,
# inferior, infuriating, elvish technology"
#
# Very crude and inelegant, repetitive approach. 
# Could make it smaller and faster and swankier, but no
# point.
#

use strict;
use warnings;

my $infile = (defined $ARGV[0]) ? $ARGV[0] : 'input.dat';
open (my $inf, '<', $infile) || die "$!\n";

my $x = 1;
my $c = 0;
my $s = 0;
my $stot = 0;

my @checks = (20,60,100,140,180,220);
my $chk = shift @checks;

while(<$inf>) {
	chomp;
	next unless length;

	if ($_ =~ /noop/) {
		$c++;

		if ($c == $chk) {
			$stot += $c*$x;
			$chk = shift @checks || 0 ;
		}
	}

	elsif (/addx\s+(.+)/) {
		$c++;
		if ($c == $chk) {
			$stot += $c*$x;
			$chk = shift @checks || 0 ;		
		}		
		$c++;

		if ($c == $chk) {
			$stot += $c*$x;
			$chk = shift @checks || 0 ;		
		}		
		$x += $1;
	}
}
printf "total = %d\n", $stot;

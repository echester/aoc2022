#!/usr/bin/perl
#
# aoc2022-09-1
#
# advent of code 2022 | ed chester | @bocs@twt.cymru
# day 9 part 1
#
# " because throwing away part 1 was the right thing to do... "
#

use strict;
use warnings;
use List::MoreUtils qw| uniq |;
use Switch;

my $infile = (defined $ARGV[0]) ? $ARGV[0] : 'input.dat';

open (my $inf, '<', $infile) || die "$!\n";

my @tailplaces;
my @moves;

# get move list
while(<$inf>) {
	chomp;
	next unless length;
	push @moves, [split / /];
}

my ($hx, $hy, $tx, $ty) = (0, 0, 0, 0);
push @tailplaces, join "_", ($tx, $ty);

foreach my $m (@moves) {
	my ($d, $l) = $m->@*;

	switch (lc $d) {

		case 'r' {
			$hx += $l;
			if ((abs($tx - $hx) > 1) && ($ty != $hy)) { 
				$ty = $hy;
				$tx++;
				push @tailplaces, join "_", ($tx, $ty);
			}
			while ($tx < $hx - 1) {
				$tx++;
				push @tailplaces, join "_", ($tx, $ty);				
			}
		}

		case 'l' {
			$hx -= $l;
			if ((abs($tx - $hx) > 1) && ($ty != $hy)) { 
				$ty = $hy;
				$tx--;
				push @tailplaces, join "_", ($tx, $ty);
			}
			while ($tx > $hx + 1) {
				$tx--;
				push @tailplaces, join "_", ($tx, $ty);				
			}
		}

		case 'u' {
			$hy += $l;
			if ((abs($ty - $hy) > 1) && ($tx != $hx)) { 
				$tx = $hx;
				$ty++;
				push @tailplaces, join "_", ($tx, $ty);				
			}			
			while ($ty < $hy - 1) {
				$ty++;
				push @tailplaces, join "_", ($tx, $ty);				
			}			
		}

		case 'd' {
			$hy -= $l;
			if ((abs($ty - $hy) > 1) && ($tx != $hx)) { 
				$tx = $hx;
				$ty--;
				push @tailplaces, join "_", ($tx, $ty);				
			}
			while ($ty > $hy + 1) {
				$ty--;
				push @tailplaces, join "_", ($tx, $ty);				
			}			
		}
	}
	push @tailplaces, join "_", ($tx, $ty);
}

@tailplaces = uniq @tailplaces;
printf "Tail visited %d locations.\n", scalar @tailplaces;

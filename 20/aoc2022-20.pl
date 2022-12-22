#!/usr/bin/perl
#
# aoc2022-20
#
# advent of code 2022 | ed chester | @bocs@twt.cymru
# day 20
#
# " "
#

use strict;
use warnings;
use Data::Dumper;

my $part = 2;
my $coordmul = ($part == 2) ? 811589153 : 1;
my $mixes = ($part == 2) ? 10 : 1;

my $infile = (defined $ARGV[0]) ? $ARGV[0] : 'input.dat';
my @coords;
my $pos = 0;

open (my $inf, '<', $infile) || die "$!\n";

# load coords into list
while(<$inf>) {
    chomp;
    next unless length;
    # fake something like a linked list without the links ;)
    push @coords, [$pos++, $coordmul * $_];
}

# part 2 addition to repeat the mixes
foreach (0 .. $mixes - 1) {
	printf "Mixing cycle %d...\n", $_;
	# part 1 mixing
	for my $coordpos (0 .. $#coords) {
		# search for where this thing ended up
		my $temppos;
		for my $p (0 .. $#coords) {
			if ($coords[$p][0] == $coordpos) {
				# got it
				$temppos = $p;
				# printf "Found %d at position %d\n", $coords[$p][1], $temppos;
				last;
			}
		}
		# grab this coordinate
		my $coordval = splice(@coords, $temppos, 1);
		# work out where its going next
		my $newpos = ($temppos + $coordval->[1]) % @coords;
		# put it there
		splice(@coords, $newpos, 0, $coordval);
	}
}

# find the position of 0 to start counting from
my $zpos;
for my $i (0 .. $#coords) {
	unless ($coords[$i][1]) {
		$zpos = $i;
		printf "Found 0 at position %d\n", $zpos;
		last;
	}
}

my $total = 0;
my $offset = 1000;

for my $n (0 .. 2) {
	$zpos += $offset;
	$zpos %= @coords;
	$total += $coords[$zpos][1];
}

printf "Mixed total is %d\n", $total;

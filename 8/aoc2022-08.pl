#!/usr/bin/perl
#
# aoc2022-08
#
# advent of code 2022 | ed chester | @bocs@twt.cymru
# day 8
#
# "well that was embarrassing... going to have to add comments in to stop
# this kind of fiasco next year... "
#

use strict;
use warnings;

my $infile = (defined $ARGV[0]) ? $ARGV[0] : 'input.dat';

open (my $inf, '<', $infile) || die "$!\n";

my @trees;
my @t;

# grab the forest into a grid
while(<$inf>) {
	chomp;
	next unless length;
	@t = split //;
	push @trees, [@t];
}

# get grid dimensions
my $w = $#t;
my $h = $#trees;

# initialise score
my $maxscore = 0;

# deepcopy the forest as a crude way of checking which trees are visible
my @vtrees = map { [@$_] } @trees;

# loop over columns replacing heights by visibility flags
for (my $c = 0; $c <= $w; $c++) {
	# from north
	my $hmax = 0;
	for (my $vn = 0 ; $vn <= $h; $vn++) {
		if (
			($vn == 0) ||
			(($vn > 0) && ($trees[$vn][$c] > $hmax))
		) {
			$vtrees[$vn][$c] = 'v';
		}
		if ($trees[$vn][$c] > $hmax) { $hmax = $trees[$vn][$c]; }
	}
	# from south
	$hmax = 0;
	for (my $vs = $h; $vs >= 0; $vs--) {
		if (
			($vs == $h) ||
			(($vs < $h) && ($trees[$vs][$c] > $hmax))
		) {
			$vtrees[$vs][$c] = 'v';
		}
		if ($trees[$vs][$c] > $hmax) { $hmax = $trees[$vs][$c]; }
	}
}

# loop over rows replacing heights by visibility flags
for (my $r = 0; $r <= $h; $r++) {
	# from west
	my $hmax = 0;
	for (my $vw = 0 ; $vw <= $h; $vw++) {
		if (
			($vw == 0) ||
			(($vw > 0) && ($trees[$r][$vw] > $hmax))
		) {
			$vtrees[$r][$vw] = 'v';
		}
		if ($trees[$r][$vw] > $hmax) { $hmax = $trees[$r][$vw]; }
	}
	# from east
	$hmax = 0;
	for (my $ve = $w ; $ve >= 0; $ve--) {
		if (
			($ve == $w) ||
			(($ve < $w) && ($trees[$r][$ve] > $hmax))
		) {
			$vtrees[$r][$ve] = 'v';
		}
		if ($trees[$r][$ve] > $hmax) { $hmax = $trees[$r][$ve]; }
	}
}

# part 1 - count visible trees
my $nvis = 0;
for (my $i = 0; $i <= $h; $i++) {
	my $t = join '', $vtrees[$i]->@*;
	$nvis += $t =~ tr/v//;
}

# part 2 - loop over individual trees 
for (my $c = 0; $c <= $w; $c++) {
	for (my $r = 0; $r <= $h; $r++) {

		# initialise its distance score (multiplier)
		my $score = 1;

		# score north view
		my $s = 0;
		for (my $j = $r - 1; $j >= 0; $j--) {
			$s++;
			last if ($trees[$j][$c] >= $trees[$r][$c]);
		}
		$score *= $s;

		# score south view
		$s = 0;
		for (my $j = $r + 1; $j <= $h; $j++) {
			$s++;
			last if ($trees[$j][$c] >= $trees[$r][$c]);
		}
		$score *= $s;

		# score west
		$s = 0;
		for (my $j = $c - 1; $j >= 0; $j--) {
			$s++;
			last if ($trees[$r][$j] >= $trees[$r][$c]);
		}
		$score *= $s;

		# score east
		$s = 0;
		for (my $j = $c + 1; $j <= $w; $j++) {
			$s++;
			last if ($trees[$r][$j] >= $trees[$r][$c]);
		}
		$score *= $s;

		# update max score if this tree is better
		if ($score > $maxscore) { $maxscore = $score; }
	}
}

printf "Part 1 : Visible trees = %d\n", $nvis;
printf "Part 2 : Max score = %d\n", $maxscore;

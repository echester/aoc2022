#!/usr/bin/perl
#
# aoc2022-09-2
#
# advent of code 2022 | ed chester | @bocs@twt.cymru
# day 9 part 2 
#
# " because throwing away part 1 was the right thing to do... "
# This took so long i'm going to comment every. single. line. 

# always use strict, because you should
use strict;

# always use warnings, because they're helpful
use warnings;

# going to grab a convenient way to uniqify an array
use List::MoreUtils qw| uniq |;

# set up a list of unit vectors for each direction indexed by a direction name letter
my %deltas = ('r' => [1,0], 'l' => [-1,0], 'u' => [0,1], 'd' => [0,-1]);

# filename to load, defaults to input.dat if missing
my $infile = (defined $ARGV[0]) ? $ARGV[0] : 'input.dat';

# initialise an array to keep a log of where the tail has been
my @tailplaces;

# function that creates a rope (array) of required number of knots (references)
sub makeRope($) {
	my @rope;
	push @rope, [0,0] foreach (0 .. shift() - 1);
	return @rope;
}

# function that implements signum using the spaceship operator for fun
sub sgn($) {
	return shift() <=> 0;
}

# function that takes a knot position and a pair of offsets and returns new knot position
sub moveknot($$$) {
	# knot reference, offset x, offset y
	my ($kr, $dx, $dy) = @_;
	# where it was before
	my ($kx, $ky) = (${$kr}[0], ${$kr}[1]);
	# where it is now
	return [$kx + $dx, $ky + $dy];
}

# function that moves one knot in response to where the next knot along is
sub slither($$) {
	# move the rope of knots
	my ($headref, $tailref) = @_;
	# locations of consecutive pair of knots - in here, calling these head and tail even though
	# they may be in the middle of the rope
	my ($hx, $hy, $tx, $ty) = (${$headref}[0], ${$headref}[1], ${$tailref}[0], ${$tailref}[1]);
	# head horiz, tail diagonal
	if ( (abs($hx - $tx) > 1) && ($hy != $ty) ) { 
		$tailref = moveknot($tailref, sgn($hx - $tx), sgn($hy - $ty));
	}
	# head horiz, tail horiz	
	elsif ( (abs($hx - $tx) > 1) && ($hy == $ty) ) { 
		$tailref = moveknot($tailref, sgn($hx - $tx), 0);
	}
	# head vert, tail diagonal	
	elsif ( (abs($hy - $ty) > 1) && ($hx != $tx) ) { 
		$tailref = moveknot($tailref, sgn($hx - $tx), sgn($hy - $ty));
	}
	# head vert, tail vert	
	elsif ( (abs($hy - $ty) > 1) && ($hx == $tx) ) { 
		$tailref = moveknot($tailref, 0, sgn($hy - $ty));
	}
	# return modified tail position
	return $tailref;
}

# create a rope made of so many knots (part 1: 2, part 2: 10)
my @rope = makeRope(10);

# get the input moves
open (my $inf, '<', $infile) || die "$!\n";
while(<$inf>) {
	chomp;
	next unless length;
	my ($d, $l) = split / /;
	# get the offset direction (unit vector) for this move 
	my @heading = $deltas{lc $d}->@*;
	# loop over that unit vector move the required number of times
	for (my $step = 0; $step < $l; $step++) {
		# move the head first
		$rope[0] = moveknot($rope[0], $heading[0], $heading[1]);
		# move the rest
		for (my $otherknots = 1; $otherknots < scalar @rope ; $otherknots++) {
			$rope[$otherknots] = slither($rope[$otherknots-1], $rope[$otherknots]);
		}
		# log the tail knot
		push @tailplaces, join '_', $rope[-1]->@*;
	}
}

# uniqify the places the tail has been - we don't care where its been, just
# how many there are.
@tailplaces = uniq @tailplaces;
# report result
printf "Tail visited %d locations.\n", scalar @tailplaces;

#!/usr/bin/perl
#
# aoc2022-10-2
#
# advent of code 2022 | ed chester | @bocs@twt.cymru
# day 10 part 2
#
# "the ringing of horrendous, cracked bells of memory
# as they bash against the broken screen of inscrutible,
# inferior, infuriating, elvish technology"
#
# (This took a lot of tinkering, and still isn't quite
# right - first line of output is skewiff :( )
#

use strict;
use warnings;

sub inRange($$$) {
	my ($value, $lower, $upper) = @_;
	return (($value >= $lower) && ($value <= $upper)) ? 1:0;
}

sub inScope($$$) {
	my ($value, $expect, $tol) = @_;
	my $rv = 0;
	if (inRange($value, $expect - $tol, $expect + $tol)) {
		$rv = 1;
	}
	return $rv;
}

my $infile = (defined $ARGV[0]) ? $ARGV[0] : 'input.dat';
open (my $inf, '<', $infile) || die "$!\n";

my $x = 1;
my $c = 0;
my $crt;

while(<$inf>) {
	chomp;
	next unless length;

	if ($_ =~ /noop/) {
		$c++;
		if (inScope($c % 40, $x, 1)) { $crt .= '#';	} 
		else { $crt .= '.'; }
	}

	elsif (/addx\s+(.+)/) {
		$c++;
		if (inScope($c % 40, $x, 1)) { $crt .= '#';	} 
		else { $crt .= '.'; }
		$c++;
		$x += $1;
		if (inScope($c % 40, $x, 1)) { $crt .= '#';	} 
		else { $crt .= '.'; }
	}
}

for (my $i = 0; $i<=240; $i++) {
	my $this = substr($crt, $i, 1);
	unless (($i) % 40) { print "\n"; }
	print $this;
}


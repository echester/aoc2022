#!/usr/bin/perl
#
# aoc2022-25
#
# advent of code 2022 | ed chester | @bocs@twt.cymru
# day 25
#
# "Well thankfully that's over. I love it and hate it in equal measure. It reminds me I am not
# a software engineer, and that there are many things I never properly learned. But, it also
# reminds me to learn and think properly, and I do get better. I cannot entertain the idea of 
# changing language every day. Last year was Perl, Python, and Verilog. This year the ALU problem
# wasn't so amenable to a HDL solution. Overwhelmingly perl this time, but I do have good intentions
# of cleaning up some code and tweaking it into Raku. Let's see how long that lasts... "
#

use strict;
use warnings;
use POSIX qw| floor |;

my $radix = 5;

sub snafu2dec($) {
	my $dec = 0;
	my $posval = 1;
	my @snafuDigits = reverse split //, shift;
	while (@snafuDigits) {
		my $d = shift @snafuDigits;
		$d =~ s/-/-1/;
		$d =~ s/=/-2/;
		$dec += $d * $posval;
		$posval *= $radix;
	}
	return $dec;
}

sub dec2snafu($) {
	my $dec = shift;
	my $snafu = '';
	while ($dec != 0) {
		my $s = $dec % $radix;
		my $a = 0;
		if ($s == 3) { $snafu = '=' . $snafu; $a = 2; }
		elsif ($s == 4) { $snafu = '-' . $snafu; $a = 1; }
		else { $snafu = $s . $snafu; }
		$dec = floor(($dec + $a)/$radix);
	}
	return $snafu;
}

my $infile = (defined $ARGV[0]) ? $ARGV[0] : 'input.dat';
my $total = 0;

open (my $inf, '<', $infile) || die "$!\n";

while(<$inf>) {
	chomp;
	next unless length;
	$total += snafu2dec($_);
}

printf "total = %d\n", $total;
printf "snafu = %s\n", dec2snafu($total);

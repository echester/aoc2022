#!/usr/bin/perl
#
# aoc2022-03
#
# advent of code 2022 | ed chester | @bocs@twt.cymru
# day 3
# part 1
#

use strict;
use warnings;

sub halfString($) {
	my $s = shift;
	return ( 
		substr ($s, 0, (length $s)/2),
		substr ($s, (length $s)/2, length $s) );
}

sub inString($$) {
	my ($ch, $st) = @_;
	return (index($st, $ch) != -1);
}

sub getCommon($$) {
	my ($s1, $s2) = @_;
	my $common = '';
	foreach my $i (0..length($s1)-1) {
		my $ch = substr ($s1, $i, 1);
		my $ir = index($s2, $ch);
		if ($ir != -1) {
			return $ch;
		}
	}
}

sub scoreChar($) {
	my $ch = shift;
	my $v = 0;
	if ($ch =~ /[a-z]/) { $v = ord($ch) - 96; }
	elsif ($ch =~ /[A-Z]/) { $v = ord(lc $ch) - 96 + 26; }
	return $v;
}
	
my $sumprior = 0;
my $infile = (defined $ARGV[0]) ? $ARGV[0] : 'input.dat';

open (INF, '<', $infile) || die "$!\n";

while(<INF>) {
	chomp;
	next unless length;
	my ($r1, $r2) = halfString($_);
	my $err = getCommon($r1, $r2);
	$sumprior += scoreChar($err);
}

close INF;
printf "Part 1 score = %d\n", $sumprior;

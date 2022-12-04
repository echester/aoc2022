#!/usr/bin/perl
#
# aoc2022-03-pt2
#
# advent of code 2022 | ed chester | @bocs@twt.cymru
# day 3
# part 2
#

use strict;
use warnings;

sub getCommon3($$$) {
	my ($s1, $s2, $s3) = @_;
	my $common = '';
	my @s1c = split //, $s1;
	foreach my $c (@s1c) {
		if ( (index($s2, $c)!= -1) && (index($s3, $c)!= -1) ) {	$common = $c; }
	}
	return $common;
}

sub scoreChar($) {
	my $ch = shift;
	my $v = 0;
	if ($ch =~ /[a-z]/) { $v = ord($ch) - 96; }
	elsif ($ch =~ /[A-Z]/) { $v = ord(lc $ch) - 96 + 26; }
	return $v;
}
	
my $badgetotal = 0;
my $infile = (defined $ARGV[0]) ? $ARGV[0] : 'input.dat';

open (INF, '<', $infile) || die "$!\n";
my @packs;

while(<INF>) {
	chomp;
	next unless length;
	push @packs, $_;
	if ($. % 3 == 0) { 
		my $badge = getCommon3($packs[0], $packs[1], $packs[2]);
		$badgetotal += scoreChar($badge);
		@packs = ();
	}
}

close INF;
printf "Part 2 score = %d\n", $badgetotal;

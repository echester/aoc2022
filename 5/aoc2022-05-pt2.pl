#!/usr/bin/perl
#
# aoc2022-05-pt2
#
# advent of code 2022 | ed chester | @bocs@twt.cymru
# day 5, part 2
#
# "Surely this is the first turning point..."
# ... yep, it was.
#
# Apart from anything else I achieved this day, I remembered to use a properly-
# named filehandle that will autoclose, saving me a single, simple, and boring
# line of code. Behold $inf!
#

use strict;
use warnings;
use Data::Dumper;
use List::Util qw| max |;

my $infile = (defined $ARGV[0]) ? $ARGV[0] : 'input.dat';

my @initStackRows;
my @moveList;
my $nStacks;
my @stacks;

open (my $inf, '<', $infile) || die "$!\n";

# grab input areas
while(<$inf>) {
	chomp;
	# initial stacks
	if (/^[\D]+$/) { push @initStackRows, $_; }
	# the stack list
	elsif (/^[\d\s]+$/) { 
		s/^\s+//;
		$nStacks = max(split /\s+/);
	}
	# move instructions
	elsif (/^move.+$/) { push @moveList, $_; }
}

# map the initial stacks
foreach my $row (@initStackRows) {
	my $stackid = 0;
	for (my $i = 0; $i < $nStacks; $i++) {
		my $tmp = substr($row, $i*4, 4);
		if ($tmp =~ /\[(\D)\]/) {
			# this weirdass thing is explicit dereference 
			push $stacks[$stackid]->@*, $1;
		}
		$stackid++;
	}
}

# process the move list
foreach my $m (@moveList) {
	my @temp = ();
	# get the move instructions
	$m =~ /\D+(\d+).+(\d+).+(\d+)/;
	my ($nCrates, $from, $to) = ($1, $2-1, $3-1);
	# perform the moves
	for (my $n = 0; $n < $nCrates; $n++) {
		my $movingCrate = shift @{$stacks[$from]};
		# pretend to drop crates in a separate stack
		# to reverse their order
		push @temp, $movingCrate;
	}
	# drop the pretend stack on the real stack
	unshift $stacks[$to]->@*, @temp;
}

# report top of each stack
print "Part 2 result: ";
for (my $s = 0; $s < $nStacks; $s++) {
	print shift @{$stacks[$s]};
}

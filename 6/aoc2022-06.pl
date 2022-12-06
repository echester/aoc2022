#!/usr/bin/perl
#
# aoc2022-06
#
# advent of code 2022 | ed chester | @bocs@twt.cymru
# day 6
#
# "Far too many ways to skin this particular elf-cat. 
# Very much the making of a mountain outfrom a molehill."
#

use strict;
use warnings;

use lib '../';
use aoc;

my $infile = (defined $ARGV[0]) ? $ARGV[0] : 'input.dat';

# grab message
my $message = do {
    local $/ = undef;
    open my $fh, "<", $infile || die "$!\n";
    <$fh>;
};

# loop over parts 1 and 2
foreach my $l (4,14) {

	# search for start positions of messages after 
	# unique marker strings of required length
	for (my $i=$l; $i<length $message; $i++) {
		# get candidate marker
		my $asm = substr $message, $i-$l, $l;
		# check it for duped chars
		if (countCharDupes($asm) == 0) {
			printf "Length %d position = %d\n", $l, $i;
			last;
		}
	}

}

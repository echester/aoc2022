#!/usr/bin/perl
#
# aoc2022-14-1
#
# advent of code 2022 | ed chester | @bocs@twt.cymru
# day 14 part 1
#
# "Sometimes even things that look simple and complete will try to lull you into a false 
# sense of security with their compelling and superficial visage. What they're really
# doing is lulling you into the corner with a whisky. I came back to this a day later, with 
# a prod from the community, to realise my $maxdepth thinking was faulty. All good now."
#


use strict;
use warnings;
use List::Util qw| min max |;

my $infile = (defined $ARGV[0]) ? $ARGV[0] : 'input.dat';

my @hardstuff;
my $maxdepth = 0;

open (my $inf, '<', $infile) || die "$!\n";

# scan the cave
while(<$inf>) {
    chomp;
    s/\s//g;
    my @vertices = split /->/;
    for (my $i=1; $i<=$#vertices; $i++) {
        my ($v1x, $v1y) = split /,/, $vertices[$i-1];
        my ($v2x, $v2y) = split /,/, $vertices[$i];

        $maxdepth = max($v1y, $v2y, $maxdepth);


        # y stays the same
        if ($v1y == $v2y) {
            for (my $j=min($v1x, $v2x); $j<=max($v1x, $v2x); $j++) {
                $hardstuff[$j][$v1y]++;
            }
        }
        else {
            # x stays the same
            for (my $j=min($v1y, $v2y); $j<=max($v1y, $v2y); $j++) {
                $hardstuff[$v1x][$j]++;
            }            
        }
    }
}

my ($sandx, $sandy) = (500, 0);
my $grains = 0;

while (1) {
    # abyss condition! 
    last if ($sandy > $maxdepth);

    # sand down
    if (!defined $hardstuff[$sandx][$sandy+1]) {
        $sandy++;
    }
    # sand left
    elsif (!defined $hardstuff[$sandx-1][$sandy+1]) {
        $sandx--;
        $sandy++;
    }
    # fall right
    elsif (!defined $hardstuff[$sandx+1][$sandy+1]) {
        $sandx++;
        $sandy++;
    }
    # can't move, add it as a blockage and drop the next grain
    else {
        $hardstuff[$sandx][$sandy]++;
        ($sandx, $sandy) = (500, 0);
        $grains++;
    }
}

printf "%d grains trapped\n", $grains;

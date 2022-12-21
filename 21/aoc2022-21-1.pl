#!/usr/bin/perl
#
# aoc2022-21-1
#
# advent of code 2022 | ed chester | @bocs@twt.cymru
# day 21 part 1
#
# "For the first time in a long time, I see how to do this straight away."
#

use strict;
use warnings;

my $infile = (defined $ARGV[0]) ? $ARGV[0] : 'input.dat';

my %rels;
my %vals;

open (my $inf, '<', $infile) || die "$!\n";

# store the input into either the relations hash or the values hash
while(<$inf>) {
    s/\s//g;
    # store relations
    if (/(\D{4}):(\D{4}.+\D{4})/) { $rels{$1} = $2; }
    # store values
    elsif (/(\D{4}):([+-]?\d+)/) { $vals{$1} = $2; }
}

YELL: { 
    while(1) {
        foreach (keys %rels) {
            my @relvars = split /[+-\/*]/, $rels{$_};
            foreach my $rv (@relvars) {
                if (grep( /$rv/, keys %vals)) {
                    $rels{$_} =~ s/$rv/$vals{$rv}/g;
                }
            }
            if ($rels{$_} =~ /\d+[+-\/*]\d+/) {
                # calculate it, store the value for next replacement, and overwrite
                # the rel so we ignore it next time 
                $rels{$_} = $vals{$_} = eval $rels{$_};
                last YELL if ( ($_ eq 'root') || ($_ eq 'humn') );
            }
        }
    } 
}

printf "root monkey yells %d\n", $vals{'root'};
printf "done in %d s\n", time() - $^T;

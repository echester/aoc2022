package aoc;
use strict;
use warnings;
use Exporter;

our @ISA = qw( Exporter );
our @EXPORT = qw( numArrSort halfString inString );

# numerical sort of array
sub numArrSort($) {
    my $ar = shift;
    return sort { $a <=> $b } @$ar;
}

# splits even-lengthed string in 2, returns list
sub halfString($) {
    my $s = shift;
    return ( 
        substr ($s, 0, (length $s)/2),
        substr ($s, (length $s)/2, length $s) );
}

# returns boolean if character is found in string
sub inString($$) {
    my ($ch, $st) = @_;
    return (index($st, $ch) != -1);
}

1;
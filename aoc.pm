package aoc;
use strict;
use warnings;
use Exporter;

our @ISA = qw( Exporter );
our @EXPORT = qw( numArrSort halfString inString isRangeSubset);

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

sub isRangeSubset($$$$) {
	# takes 2 numeric ranges as 4 args
	# returns: -1 if the ranges do not overlap; 0 if one range completely 
	# overlaps the other; >0 if there is partial overlap
	my ($fl, $fu, $sl, $su) = @_;
	my $rv = -1;
	unless ( ($fu < $sl) || ($su < $fl)	) {	$rv = 1; }
	if ( (($fl >= $sl) && ($fu <= $su)) || (($sl >= $fl) && ($su <= $fu)) ) { $rv = 0; }
	return $rv;
}

1;
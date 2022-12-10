package aoc;
use strict;
use warnings;
use Exporter;

our @ISA = qw( Exporter );
our @EXPORT = qw|
 numArrSort
 halfString
 inString
 isRangeSubset
 unionsize
 sortElemAlpha
 countCharDupes
 sgn
|;

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

sub unionsize($$) {
	# return integer that is the number of elements in first 
	# referenced array that are also present in the second
	# *there must be a better way to do this*
	my ($a, $b) = @_;
	my $c = 0;
	foreach my $i (@$a) {
		if (grep { $i eq $_ } @$b) {
			$c++;
		}
	}
	return $c;
}

sub sortElemAlpha($) {
	# replace strings within an array by alphabetically
	# sorted versions of themselves
	my $arr = shift;
	return map { join '',sort(split //) } @$arr;
}

sub countCharDupes($) {
	# return number of a characters in a string that 
	# appear more than once
	my $s = shift;
	my $n = 0;
	# loop over characters
	for (my $i = 0; $i < length $s; $i++) {
		my $c = substr $s, $i, 1;
		my $count = () = $s =~ /\Q$c/g;
		if ($count > 1) { $n++; }
	}
	return ($n > 0) ? $n - 1 : 0;
}

# function that implements signum using the spaceship operator for fun
sub sgn($) {
	return shift() <=> 0;
}

1;
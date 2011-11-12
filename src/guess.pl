#!/usr/bin/perl -w
#
# guess.pl - guessing game in perl
#
# This is written to demonstrate this language versus the same program
# written in other languages.
#
# 25-Oct-2003	Brendan Gregg	Created this.
# 07-Jul-2005	Jepri		Added use strict!  Tweaked code
# 17-Jul-2006	Mark Suter	Tweaked style

use strict;

my $scorefile = "highscores_pl";
my $num   = 0;
my $guess = -1;

print "guess.pl - Guess a number between 1 and 100\n\n";

### Generate random number
my $answer = 1 + int rand 99;

### Play game
while ( $guess != $answer ) {
    print "Enter guess ", ++$num, ": ";
    $guess = <STDIN>;
    print $guess < $answer ? "Higher...\n" : "Lower...\n";
}
print "Correct! That took $num guesses.\n\n";

### Save high score
print "Please enter your name: ";
my $name = <STDIN>;
chomp $name;
open OUTFILE, ">> $scorefile" or die "ERROR: Can't write to $scorefile: $!\n";
print OUTFILE "$name $num\n";
close OUTFILE;

### Print high scores
print "\nPrevious high scores,\n";
open INFILE, $scorefile or die "ERROR: Can't read from $scorefile: $!\n";
print <INFILE>;
close OUTFILE;


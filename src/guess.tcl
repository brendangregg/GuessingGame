#!/opt/sfw/bin/tcl
#
# guess.tcl - guessing game in tcl
#
# This is written to demonstrate this language versus the same program 
# written in other languages.
#
# 30-Mar-2004   Brendan Gregg   Created this.

set scorefile "highscores_tcl"
set guess -1
set num 0

puts "guess.tcl - Guess a number between 1 and 100\n"

### Generate random number
set answer [expr int(rand()*99 + 1)]

### Play game
while {$guess != $answer} {
	set num [expr $num + 1]
	puts -nonewline "Enter guess $num: "
	flush stdout
	set guess [gets stdin]
	if {$guess < $answer} {
		puts "Higher..."
	} elseif {$guess > $answer} {
		puts "Lower..."
	}
}

puts "Correct! That took $num guesses.\n"

### Save high score
puts -nonewline "Please enter your name: "
flush stdout
set name [gets stdin]
set outfile [open $scorefile a 0644]
puts $outfile "$name $num"
close $outfile

### Print high scores
puts "\nPrevious high scores,"
set infile [open $scorefile r 0644]
while {[gets $infile line] >= 0} {
	puts $line
}
close $infile

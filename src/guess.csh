#!/usr/bin/csh
#
# guess.csh - guessing game in csh (C Shell)
#
# This is written to demonstrate this language versus the same program 
# written in other languages.
#
# 25-Oct-2003	Brendan Gregg	Created this.

set scorefile = "highscores_csh"
set guess = -1
set num = 0

echo "guess.csh - Guess a number between 1 and 100"
echo

### Generate random number
set answer = `perl -e 'print (sprintf("%.0f",rand(99)) + 1);'`

### Play game
while ($guess != $answer)
	@ num++
	echo -n "Enter guess ${num}: "
	set guess = $<
	if ($guess < $answer) then
		echo "Higher..."
	else if ($guess > $answer) then
		echo "Lower..."
	endif
end
echo "Correct! That took $num guesses."
echo

### Save high score
echo -n "Please enter your name: "
set name = $<
echo $name $num >> $scorefile

### Print high scores
echo
echo "Previous high scores,"
cat $scorefile

#!/usr/bin/sh
#
# guess.sh - guessing game in sh (Bourne Shell)
#
# This is written to demonstrate this language versus the same program 
# written in other languages.
#
# 25-Oct-2003	Brendan Gregg	Created this.

scorefile="highscores_sh"
guess=-1
num=0

echo "guess.sh - Guess a number between 1 and 100\n"

### Generate random number
# This random number is generated externally by invoking perl. This
# isn't a huge consession within a Bourne script as all arithmetic is
# normally processed by an external command anyway - "expr".
answer=`perl -e 'print (sprintf("%.0f",rand(99)) + 1);'`

### Play game
while [ $guess -ne $answer ]; do
	num=`expr $num + 1`
	echo "Enter guess $num: \c"
	read guess
	if [ $guess -lt $answer ]; then
		echo "Higher..."
	elif [ $guess -gt $answer ]; then
		echo "Lower..."
	fi
done
echo "Correct! That took $num guesses.\n"

### Save high score
echo "Please enter your name: \c"
read name
echo $name $num >> $scorefile

### Print high scores
echo "\nPrevious high scores,"
cat $scorefile

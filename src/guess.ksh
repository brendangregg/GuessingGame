#!/usr/bin/ksh
#
# guess.ksh - guessing game in ksh (Korn Shell)
#
# This is written to demonstrate this language versus the same program 
# written in other languages.
#
# 25-Oct-2003	Brendan Gregg	Created this.

scorefile="highscores_ksh"
guess=-1
typeset -i num=0

print "guess.ksh - Guess a number between 1 and 100\n"

### Generate random number
(( answer = RANDOM % 100 + 1 ))

### Play game
while (( guess != answer )); do
	num=num+1
	read guess?"Enter guess $num: "
	if (( guess < answer )); then
		print "Higher..."
	elif (( guess > answer )); then
		print "Lower..."
	fi
done
print "Correct! That took $num guesses.\n"

### Save high score
read name?"Please enter your name: "
print $name $num >> $scorefile

### Print high scores
print "\nPrevious high scores,"
cat $scorefile

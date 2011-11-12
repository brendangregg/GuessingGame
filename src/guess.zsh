#!/usr/bin/zsh
#
# guess.zsh - guessing game in zsh (Z Shell)
#
# This is written to demonstrate this language versus the same program 
# written in other languages.
#
# 25-Oct-2003	Brendan Gregg	Created this.

scorefile="highscores_zsh"
guess=-1
typeset -i num=0

print "guess.zsh - Guess a number between 1 and 100\n"

### Generate random number
(( answer = RANDOM % 100 + 1 ))

### Play game
while [[ guess -ne answer ]]; do
	num=num+1
	read "guess?Enter guess $num: "
	if [[ guess -lt answer ]] { print "Higher..." }
	if [[ guess -gt answer ]] { print "Lower..." }
done
print "Correct! That took $num guesses.\n"

### Save high score
read "name?Please enter your name: "
print $name $num >> $scorefile

### Print high scores
print "\nPrevious high scores,"
cat $scorefile

#!/usr/bin/bash
#
# guess.bash - guessing game in BASH (Bourne Again Shell)
#
# This is written to demonstrate this language versus the same program 
# written in other languages.
#
# 17-Oct-2004	Brendan Gregg	Created this.

scorefile="highscores_bash"
guess=-1
typeset -i num=0

echo -e "guess.bash - Guess a number between 1 and 100\n"

### Generate random number
(( answer = RANDOM % 100 + 1 ))

### Play game
while (( guess != answer )); do
	num=num+1
	read -p "Enter guess $num: " guess
	if (( guess < answer )); then
		echo "Higher..."
	elif (( guess > answer )); then
		echo "Lower..."
	fi
done
echo -e "Correct! That took $num guesses.\n"

### Save high score
read -p "Please enter your name: " name
echo $name $num >> $scorefile

### Print high scores
echo -e "\nPrevious high scores," 
cat $scorefile

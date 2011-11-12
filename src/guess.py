#!/usr/bin/python
#
# guess.py - guessing game in python
#
# This is written to demonstrate this language versus the same program 
# written in other languages.
#
# 26-Oct-2003	Brendan Gregg	Created this.

import random

scorefile = "highscores_py"
guess = -1
num = 0

print "guess.py - Guess a number between 1 and 100\n"

### Generate random number
answer = random.randint(1,100)


### Play game
while guess != answer:
	num = num + 1
	prompt = "Enter guess " + str(num) + ": "
	guess = input("Enter guess " + str(num) + ": ")
	if guess < answer:
		print "Higher..."
	elif guess > answer:
		print "Lower..."

print "Correct! That took",num,"guesses.\n"


### Save high score
name = raw_input("Please enter your name: ")
try:
	outfile = open(scorefile,"a")
	outfile.write(name + " " + str(num) + "\n")
	outfile.close()
except:
	print "ERROR: Can't write to", scorefile


### Print high scores
print "\nPrevious high scores,"
try:
	infile = open(scorefile,"r")
	lines = infile.read()
	print lines
	infile.close()
except:
	print "ERROR: Can't read from", scorefile

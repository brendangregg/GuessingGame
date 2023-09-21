#!/usr/bin/python
#
# guess.py - guessing game in python 3
#
# This is written to demonstrate this language versus the same program 
# written in other languages.
#
# 26-Oct-2003	Brendan Gregg	  Created this.
# 22-Oct-2022   Daniel Eberhard   Updated to Python 3.

import random

scorefile = "highscores_py"
guess = -1
num = 0

print("guess.py - Guess a number between 1 and 100\n")

### Generate random number
answer = random.randint(1, 100)


### Play game
while guess != answer:
	num = num + 1
	guess = int(input("Enter guess {}: ".format(num)))
	if guess < answer:
		print("Higher...")
	elif guess > answer:
		print("Lower...")

print("Correct! That took {} guesses.\n".format(num))


### Save high score
name = input("Please enter your name: ")
try:
	with open(scorefile, "a") as outfile:
		outfile.write("{} {}\n".format(name, num))
except:
	print("ERROR: Can't write to {}".format(scorefile))


### Print high scores
print("\nPrevious high scores,")
try:
	with open(scorefile, "r") as infile:
		lines = infile.read()
		print(lines)
except:
	print("ERROR: Can't read from {}".format(scorefile))

#
# guess.nim - guessing game in nim
#
# This is written to demonstrate this language versus the same program
# written in other languages.
#
# COMPILE:
#       nim compile guess.nim
#
# 31-Aug-2018   Scott Emmons   Created.
#

import random, strutils

randomize()

let
  answer = rand(99)+1  # For nim 0.17 or older, use random(100)+1 instead
const
  scorefile = "highscores_nim"
var
  guess = -1
  num = 0

echo("guess.nim - Guess a number between 1 and 100\n")

# Play game
while guess != answer:
  num+=1
  stdout.write("Enter guess ", num, ": ")
  guess = parseInt(readLine(stdin))
  if guess < answer:
    echo("Higher...")
  elif guess > answer:
    echo("Lower...")

echo("Correct! That took ", num, " guesses.\n")

# Save high score
stdout.write("Please enter your name: ")
let name = readLine(stdin)

try:
  let outfile = open(scorefile, fmAppend)
  write(outfile, name & " " & $(num) & "\n")
  close(outfile)
except IOError:
  echo("ERROR: Can't write to ", scorefile)

# Print high scores
echo("\nPrevious high scores:")
try:
  let infile = open(scorefile)
  echo readAll(infile)
  close(infile)
except IOError:
  echo("ERROR: Can't read from ", scorefile)

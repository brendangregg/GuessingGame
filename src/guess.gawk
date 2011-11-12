#!/bin/gawk -f
#
# guess.gawk - guessing game in gawk
#
# This is written to demonstrate this language versus the same program 
# written in other languages.
#
# 23-Mar-2006	R. Prescott Loui	Created this.

BEGIN {
  scorefile = "highscores_gawk"

  # generate random number
  srand()
  answer = int(99*rand()+1)

  print "guess.gawk - guess a number between 1 and 100\n"

  # play game
  do {
    printf "Enter guess "++num": "
    getline guess
    if (guess < answer) print "Higher..."
    if (guess > answer) print "Lower..."
  } while (guess != answer)

  print "\nCorrect!  That took "num" guesses.\n"

  # save high score
  printf "Please enter your name: "
  getline name
  print name,num >> scorefile

  # print high scores
  print "\nPrevious high scores,"
  system("cat "scorefile)
}

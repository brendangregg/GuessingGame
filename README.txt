INTRODUCTION

GuessingGame is a simple game written in a variety of programming languages, so
that the languages themselves can be compared.  The program covers many
programming fundamentals: variable declaration and manipulation (strings and
integers), screen output, keyboard input, loops, if statements, file input and
file output.

EXAMPLE

Below is an example of playing the guessing game. The program randomly picks a
number which you try to guess.  You enter your name which is saved to a high
score file and the previous high scores are printed out.  The version here is
the Perl version, however all versions are designed to appear as identical as
possible:

  mars:> ./guess.pl
  guess.pl - Guess a number between 1 and 100
  
  Enter guess 1: 50
  Higher...
  Enter guess 2: 75
  Lower... 
  Enter guess 3: 67
  Lower... 
  Enter guess 4: 58
  Lower... 
  Enter guess 5: 54
  Higher...
  Enter guess 6: 56
  Lower... 
  Enter guess 7: 55
  Correct! That took 7 guesses.
  
  Please enter your name: Brendan Gregg
  
  Previous high scores,
  Fred Nurk 5
  Fred 6
  Brendan Gregg 7

And the high score file was:

  mars:> ls -l highscores_pl 
  -rw-r--r--   1 brendan  other         35 Oct 26 01:31 highscores_pl

INSTALLATION

The programs are in the "src" directory.  At the top of each program is a comment
that describes how to run the program, and compile it if necessary.  There is no
installer (or Makefile), instead, read the programs themselves.

Any additional documentation is in the "doc" directory.

LINKS

http://www.brendangregg.com/guessinggame.html	project website
https://github.com/brendangregg/GuessingGame	source repository

/*
 * guess.rexx - guessing game in REXX
 *
 * This is written to demonstrate this language versus the same program
 * written in other languages.
 *
 * RUN:
 *       rexx guess.rexx
 *
 * 01-Sep-2018  Scott Emmons   Created.
 */

answer = random(99)+1
scorefile = 'highscores_rexx'
guess = -1
num = 0

say 'guess.rexx - Guess a number between 1 and 100'
say ''

/* Play game */
do while guess \= answer
  num = num+1
  say 'Enter guess' num ':'
  pull guess
  if guess < answer then
    say 'Higher...'
  else if guess > answer then
    say 'Lower...'
end

say 'Correct! That took' num 'guesses.'
say ''

/* Save high score */
say 'Please enter your name:'
parse pull name

if lineout(scorefile, name num) \= 0 then
  say 'ERROR: Cant write to' scorefile

/* Print high scores */
say ''
say 'Previous high scores:'

/* Rewind file */
linein(scorefile, 1, 0)

do while lines(scorefile) > 0
  say linein(scorefile)
end

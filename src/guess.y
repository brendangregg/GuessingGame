/*
   guess.y - guessing game in Yorick
  
   This is written to demonstrate this language versus the same program
   written in other languages.
  
   RUN:
  	yorick
  	#include "guess.y"
  
   15-May-2006  Brendan Gregg   Created this.
 */

scorefile = "highscores_yorick";
guess = -1;
num = 0;
name = "";
line = "";

write, format="%s\n\n", "guess.y - Guess a number between 1 and 100";

/* Generate random number */
randomize;
answer = ceil(random() * 99) + 1;

/* Play game */
while (guess != answer)
{
  num++;
  write, format="%s %d: ", "Enter guess", num;
  read, prompt="", format="%d", guess;
  if (guess < answer)
    write, format="%s\n", "Higher..."
  else if (guess > answer)
    write, format="%s\n", "Lower..."
}
write, format="Correct! That took %d guesses.\n\n", num;

/* Save high score */
read, prompt="Please enter your name: ", format="%[^\n]", name;
fd = open(scorefile, "a");
write, fd, format="%s %d\n", name, num;
close, fd;

/* Print high scores */
write, format="\n%s\n", "Previous high scores,"
fd = open(scorefile, "r");
while (num = read(fd, format="%[^\n]", line)) {
  write, format="%s\n", line;
}
close, fd;

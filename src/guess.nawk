# guess.nawk - guessing game in nawk (New AWK)
#
# This is written to demonstrate this language versus the same program 
# written in other languages.
#
# RUN:
#	nawk -f guess.nawk	# Solaris
#	awk -f guess.nawk	# Linux
#
# 25-Oct-2003   Brendan Gregg   Created this.

BEGIN {
	num = 1
	scorefile = "highscores_nawk"

	### Generate random number ###
	srand()
	answer=int(rand() * 99 + 1)
	print "guess.nawk - guess a number between 1 and 100 ...\n"
	printf "Enter guess " num ": "
}

### Play game ###
{
	guess = $1
	if (guess == answer) {
		print "\nCorrect! That took " num " guesses.\n"

		### Save high score ###
		printf "Please enter your name: "
		getline
		name = $0
		print name,num >> scorefile 

		### Print high scores ###
		print "\nPrevious high scores,"
		system("cat " scorefile);
		exit;
	}
	if (guess < answer) 
		print "Higher..."
	if (guess > answer) 
		print "Lower..."
	num++
	printf "Enter guess " num ": "
}
	

-- guess.ex - guessing game in Euphoria
--
-- This is written to demonstrate this language versus the same program
-- written in other languages.
--
-- 26-Oct-2003   Brendan Gregg   Created this.

include get.e

constant STDIN = 0
constant STDOUT = 1
constant STDERR = 2
object name, scorefile, line
integer answer, num, guess, infile, outfile
sequence reply
num = 0
guess = -1
scorefile = "highscores_euphoria"   -- actually truncates to 8 cahrs

puts(STDOUT,"guess.ex - Guess a number between 1 and 100\n")


-- Generate random number --
answer = rand(99) + 1


-- Play game --
while guess != answer do
	num = num + 1

	printf(STDOUT,"\nEnter guess %d: ",num)
	reply = get(STDIN)
	guess = reply[2]
	if guess < answer then
		puts(STDOUT,"\rHigher...\n")
	end if
	if guess > answer then
		puts(STDOUT,"\rLower...\n")
	end if
end while
printf(STDOUT,"\rCorrect! That took %d guesses\n\n",num)


-- Save high score --
puts(STDOUT,"Please enter your name: ")
name = gets(STDIN)
name = name[1..length(name)-1]
outfile = open(scorefile,"a")
if outfile = -1 then
	printf(STDERR,"ERROR: Can't write to %s\n",scorefile)
else
	printf(outfile,"%s %d\n",{name,num})
	close(outfile)
end if


-- Print high scores --
puts(STDOUT,"\nPrevious high scores,\n\n")
infile = open(scorefile,"r")
if infile = -1 then
	printf(STDERR,"ERROR: Can't read from %s\n",scorefile)
else
	while 1 do
		line = gets(infile)
		if atom(line) then
			exit
		end if
		puts(STDOUT,line)
	end while		
	close(infile)
end if

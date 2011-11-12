c guess.for - guessing game in fortran 77   (GNU g77)
c
c This is written to demonstrate this language versus the same program 
c written in other languages.
c
c COMPILE:
c	g77 -o guess guess.for
c
c 26-Oct-2003   Brendan Gregg   Created this.

	program game

	integer guess, num, answer, infile, outfile, in_ios, ok
	character(len=80) line, name, numstr, scorefile

	guess = -1
	num = 0
	infile = 20
	outfile = 21
	in_ios = 0
	scorefile = 'highscores_for'

	write (*,100) 'guess.for - Guess a number between 1 and 100\n'

c	*** Generate random number ***
	call srand(getpid())
	answer = int(rand() * 99) + 1


c	*** Play Game ***
	do while (guess .ne. answer)
		num = num + 1
		write (*,'(A,I2,A,$)') 'Enter guess ', num, ': '
		read (*,*) guess
		if (guess .lt. answer) write (*,100) 'Higher...'
		if (guess .gt. answer) write (*,100) 'Lower...'
	enddo
	write (*,'(A,I2,A)') 'Correct! That took ', num, ' guesses.\n'


c	*** Save high score ***
	write (*,'(A,$)') 'Please enter your name: '
	read (*,100) name
	open (outfile, FILE=scorefile, STATUS='OLD', ACCESS='APPEND')
	write (outfile,'(A,'' '',I2)') name(1:len_trim(name)), num
	close (outfile)
c	... the above is g77. other compilers may prefer POSITION='APPEND'


c	*** Print high scores ***
	write (*,100) '\nPrevious high scores,'
	open (infile, FILE=scorefile, STATUS='OLD')
	do while (in_ios .eq. 0)
		read (infile,100,IOSTAT=in_ios) line
		if (in_ios .eq. 0) write (*,100) line
	enddo
	close (infile)


100	format(A)

	stop
	end

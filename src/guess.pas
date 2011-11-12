(*
  guess.pas - guessing game in pascal

  This is written to demonstrate this language versus the same program 
  written in other languages.

  16-Oct-2004   Brendan Gregg   Created this.
*)

program GuessingGame (input, output, fdata);

var 	
	infile,outfile: text;
	answer,num,guess: integer;
	scorefile: packed array [1..16] of char;
	name: packed array [1..64] of char;
	line: packed array [1..128] of char;

begin
	scorefile := 'highscores_pas';
	num := 0;

	writeln('guess.pas - Guess a number between 1 and 100');
	writeln;

	(* Generate random number *)
	randomize;
	answer := random(99) + 1;

	(* Play game *)
	repeat
		num := num + 1;
		write('Enter guess ',num,': ');
		readln(guess);
		if guess < answer then writeln('Higher...');
		if guess > answer then writeln('Lower...');
	until guess = answer;

	writeln('Correct! That took ',num,' guesses.');
	writeln;

	(* Save high score *)
	write('Please enter your name: ');
	readln(name);
	assign(outfile,scorefile);
	append(outfile);
	writeln(outfile,name,' ',num);
	close(outfile);
	
	(* Print high scores *)
	writeln('Previous high scores,');
	assign(infile,scorefile);
	reset(infile);
	while not eof(infile) do
	begin
		readln( infile, line );
		writeln(line);
	end;
	close(infile);
end.

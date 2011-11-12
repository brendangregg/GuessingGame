-- guess.ada - guessing game in Ada
--
-- This is written to demonstrate this language versus the same program
-- written in other languages.
--
-- 23-Oct-2004   Brendan Gregg   Created this.

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Numerics.Discrete_Random;

procedure Guess is
	subtype Die is Integer range 1..100;
	package Random_100 is new Ada.Numerics.Discrete_Random(Die);
	package Integer_IO is new Ada.Text_IO.Integer_IO(Integer);
	package IntIO renames Integer_IO;
	use Random_100;
	use IntIO;
	file : File_Type;
	line, name : String (1..128);
	scorefile : String := "highscores_ada";
	guess, num, answer : Integer;
	last : Natural;
	gen : Generator;
begin
	guess := -1;
	num := 0;

	Put_Line ("guess.ada - guess a number between 1 and 100 ...");
	Put_Line ("");
   
	-- Generate random number --
	Reset (gen);
	answer := Random (gen);

	-- Play game --
	Game:
	while guess /= answer
	loop
		num := num + 1;
		Put ("Enter guess ");
		IntIO.Put (num, 1);
		Put (": ");
		Get_Line (line, last);
		IntIO.Get (line, guess, last);
		if guess < answer then
			Put_Line ("Higher...");
		elsif guess > answer then
			Put_Line ("Lower...");
		end if;
	end loop Game;
	Put ("Correct! That took ");
	IntIO.Put (num, 1);
	Put_Line(" guesses.");
	Put_Line("");

	-- Save high score --
	Put ("Please enter your name: ");
	Get_Line (name, last);
	Open (file, Append_File, scorefile);
	Put (file, name (1..last));
	IntIO.Put (file, num, 5);
	Put_Line (file, "");
	Close (file);

	-- Print high scores --
	Put_Line ("");
	Put_Line ("Previous high scores,");
	Open (file, In_File, scorefile);
	while not End_Of_File(file)
	loop
		Get_Line (file, line, last);
		Put_Line (line (1..last));
	end loop;
	Close (file);
end Guess;

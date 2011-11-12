/* guess.cpp - guessing game in C++

 This is written to demonstrate this language versus the same program 
 written in other languages.

 COMPILE:
	gcc -lstdc++ -lm -o guess guess.cpp

 25-Oct-2003	Brendan Gregg	Created this.
*/

#include <iostream.h>
#include <fstream.h>
#include <stdlib.h>
#include <unistd.h>

char *scorefile = "highscores_cpp";

int main() {
	int guess = -1;
	int num = 0;
	int answer;
	char buffer[256];
	char name[256];
	ofstream outfile;
	ifstream infile;

	cout << "guess.cpp - Guess a number between 1 and 100" << endl << endl;

	// *** Generate random number ***
	srand(time(0));
	answer = rand() % 100 + 1;


	// *** Play game ***
	while ( guess != answer ) {
		num++;
		cout << "Enter guess " << num << ": ";
		cin >> guess;
		if ( guess < answer )
			cout << "Higher..." << endl;
		if ( guess > answer ) 
			cout << "Lower..." << endl;
	}
	cout << "Correct! That took " << num << " guesses." << endl << endl;


	// *** Save high score ***
	cout << "Please enter your name: ";
	cin >> name;
	outfile.open(scorefile,ios::app);
	if (! outfile) {
                cerr << "ERROR: Can't write to " << scorefile << endl;
		exit(1);
	}
	outfile << name << " " << num << endl;
	outfile.close();


	// *** Print high scores ***
	cout << endl << "Previous high scores" << endl;
	infile.open(scorefile,ios::in);
	if (! infile) {
                cerr << "ERROR: Can't read from " << scorefile << endl;
		exit(2);
        }
	while (!infile.eof()) {
		infile.getline(buffer,255);
		cout << buffer << endl;
	}
	infile.close();

	return 0;
}

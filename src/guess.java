/**
 * guess.java - guessing game in java
 *
 * This is written to demonstrate this language versus the same program 
 * written in other languages.
 *
 * COMPILE:
 *        javac guess.java
 * RUN:
 *    java guess
 *
 * 25-Oct-2003    Brendan Gregg   Created this.
 */

import java.io.*;
import java.lang.*;
import java.util.Random;

public class guess {
    public static void main(String[] args) throws IOException {
        int num = 0;
        int guess = -1;
        int answer;
        String name;
        String line;
        String result;
        String scorefile = "highscores_java";

        BufferedReader stdin
                = new BufferedReader(new InputStreamReader(System.in));

        System.out.println("guess.java - Guess a number between 1 and 100\n");

        // generate random number
        java.util.Random generator
                = new java.util.Random(System.currentTimeMillis());
        answer = generator.nextInt() / 42949673 + 50;

        // play game
        while (guess != answer) {
            num++;
            System.out.print("Enter guess " + num + ": ");
            result = stdin.readLine();
            guess = Integer.parseInt(result);
            if (guess < answer) {
                System.out.println("Higher...");
            } else if (guess > answer) {
                System.out.println("Lower...");
            }
        }
        System.out.println("Correct! That took " + num + " guesses.\n");

        // save high score
        System.out.print("Please enter your name: ");
        name = stdin.readLine();
        try {
            BufferedWriter outfile
                    = new BufferedWriter(new FileWriter(scorefile, true));
            outfile.write(name + " " + num + "\n");
            outfile.close();
        } catch (IOException exception) {
            System.out.println("ERROR: Can't read from " + scorefile + "\n");
        }

        // print high scores
        try {
            BufferedReader infile
                    = new BufferedReader(new FileReader(scorefile));
            while ((line = infile.readLine()) != null) {
                System.out.println(line);
            }
            infile.close();
        } catch (IOException exception) {
            System.out.println("ERROR: Can't read from " + scorefile + "\n");
        }
    }
}

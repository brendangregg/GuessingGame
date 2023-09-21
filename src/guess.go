/* guess.py - guessing game in golang
*
* This is written to demonstrate this language versus the same program
* written in other languages.
*
* 22-Oct-2022   Daniel Eberhard   Created.
 */

package main

import (
	"fmt"
	"io/ioutil"
	"math/rand"
	"os"
	"time"
)

func main() {
	scorefile := "highscores_go"
	guess := -1
	num := 0

	fmt.Println("guess.go - Guess a number between 1 and 100\n")

	// Generate random number
	rand.Seed(time.Now().UnixNano())
	answer := rand.Intn(99) + 1

	// Play game
	for guess != answer {
		num = num + 1
		fmt.Printf("Enter guess %d: ", num)
		_, _ = fmt.Scanf("%d\n", &guess)
		if guess < answer {
			fmt.Println("Higher...")
		} else if guess > answer {
			fmt.Println("Lower...")
		}
	}

	fmt.Println("Correct! That took", num, "guesses.\n")

	// Save high score
	fmt.Print("Please enter your name: ")
	var name string
	_, err := fmt.Scanf("%s\n", &name)
	outfile, err := os.OpenFile(scorefile, os.O_APPEND, 0666)
	if err != nil {
		outfile, err = os.OpenFile(scorefile, os.O_CREATE, 0666)
		if err != nil {
			fmt.Println("ERROR: Can't write to", scorefile)
		}
	}
	defer outfile.Close()
	if _, err = outfile.WriteString(fmt.Sprintf("%s %d\n", name, num)); err != nil {
		fmt.Println("ERROR: Can't write to", scorefile)
	}

	// Print high scores
	fmt.Println("\nPrevious high scores,")
	infile, err := os.Open(scorefile)
	if err != nil {
		fmt.Println("ERROR: Can't read from", scorefile)
	}
	defer infile.Close()
	lines, err := ioutil.ReadAll(infile)
	fmt.Printf("%s", lines)
}

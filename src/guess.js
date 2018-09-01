//
// guess.js - guessing game in javascript
//
// This is written to demonstrate this language versus the same program
// written in other languages.
//
// RUN:
//       nodejs guess.js
//
// 01-Sep-2018   Scott Emmons   Created.
//

var readline = require('readline');
var fs = require('fs');

var rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

var main=(function *() {
  const answer = Math.floor(Math.random()*100)+1;
  const scorefile = 'highscores_js';
  var guess = -1;
  var num = 0;

  console.log('guess.js - Guess a number between 1 and 100\n');

// Play game
  while (guess != answer) {
    num+=1;
    console.log('Enter guess ' + num + ':');
    guess = yield;
    if (guess < answer) {
      console.log('Higher...');
    } else if (guess > answer) {
      console.log('Lower...');
    }
  }

  console.log('Correct! That took ' + num + ' guesses.\n');

// Save high score
  console.log('Please enter your name:');
  name = yield;

  fs.writeFileSync(scorefile, name + " " + num + "\n", {'flag': 'a'});

// Print high scores
  console.log('\nPrevious high scores:');
  var input = fs.readFileSync(scorefile);
  console.log(input.toString());

  rl.close();
})();

main.next();
rl.on('line', input=>main.next(input))

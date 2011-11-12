#!/usr/local/bin/ruby -w
#
# guess.rb - guessing game in ruby
#
# This is written to demonstrate this language versus the same program 
# written in other languages.
#
# 16-Oct-2004  Brendan Gregg	Created this.
# 17-Jan-2005  Boyd Adamson	Made more ruby-ish. Added error checks.

scorefile = "highscores_rb"
guess = -1
num = 0

print "guess.rb - Guess a number between 1 and 100\n\n"

### Generate random number
answer = rand(99) + 1

### Play game
while guess != answer
  num += 1
  print "Enter guess #{num}: "
  guess = gets.to_i
  if guess < answer then print "Higher...\n" end
  if guess > answer then print "Lower...\n" end
end
print "Correct! That took #{num} guesses.\n\n"

### Save high score
print "Please enter your name: "
name = gets.chomp
begin
  open(scorefile, "a") do |file|
    file.write "#{name} #{num}\n"
  end
rescue
  $stderr.print "ERROR: Can't write to #{scorefile}: #$!\n"
  exit 1
end

### Print high scores
puts "\nPrevious high scores,"
begin
  open(scorefile) do |file|
    file.each { |line| puts line }
  end
rescue
  $stderr.print "ERROR: Can't read from #{scorefile}: #$!\n"
  exit 1
end

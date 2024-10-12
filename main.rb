require 'pry-byebug'
require_relative 'lib/game'
require_relative 'lib/human_player'
require_relative 'lib/computer_player'

game = Game.new(ComputerPlayer, HumanPlayer)
game.play

# permutations = computer.create_set_of_all_possible_codes

# set = computer.create_set_of_all_possible_codes
# guess = ["Red", "Red", "Blue", "Blue"]
# left_possibilities = computer.remove_codes_from_set(guess, set)

# left_possibilities.each do |val|
#   p val
# end

# puts left_possibilities.size

# 1. Updating Guesses on board (Done) => 1st Pomodoro
# 2. Updating feedback on board (Not needed Now) # 2nd Pomodoro Reddit login and minimax and alpha/beta pruning
# 3. Build the game such that the HumanPlayer can choose whether they want to be the code
# creator or guesser
# 4. If they decide to create the code then Computer will guess the code
# 5. Computer will follow the rules (That's the approach we're taking)
# We'll use minimax algorithm for Computer to guess the code 

# [Red Red Blue Blue] => Red pegs : 2 White pegs : 0
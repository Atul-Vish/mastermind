require 'pry-byebug'
require_relative 'lib/game'
require_relative 'lib/human_player'
require_relative 'lib/computer_player'

game = Game.new(ComputerPlayer, HumanPlayer)
game.play

computer = ComputerPlayer.new(game)
# guess = ["Red", "Red", "Blue", "Blue"]
# feedback_on_guess = [1,1]
# sample = ["Red", "Blue", "Green", "Yellow", "Orange", "Brown"].repeated_permutation(4).to_a
# sample_modified = computer.remove_codes_from_sample(guess, feedback_on_guess, sample)
# p sample_modified
# guess1 = sample_modified[0]
# p computer.feedback_hash_for_score(guess1, sample_modified)

# score_array = computer.score_array(sample_modified)
# p score_array

# p computer.guess_to_play_next(sample_modified, score_array)
# computer.guess
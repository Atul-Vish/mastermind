require "pry-byebug"
require_relative "lib/game"
require_relative "lib/human_player"
require_relative "lib/player"
require_relative "lib/computer_player"

game = Game.new(HumanPlayer, ComputerPlayer)
# p atul.create_code

# guddu = HumanPlayer.new(game)
# guess = guddu.guess_code

# computer = ComputerPlayer.new(game)
# computer.provide_feedback_on_guess(guess)

game.switch_players
p game.create_code
game.switch_players
guess = game.current_player.guess_code
if game.won?(guess)
  puts "You won the game"
else
  puts "You lost the game"
end

# binding.pry
game.provide_feedback_on_guess(guess)

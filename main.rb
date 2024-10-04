require 'pry-byebug'
require_relative 'lib/game'
require_relative 'lib/human_player'
require_relative 'lib/computer_player'

# HumanPlayer guess_code method testing
game = Game.new(HumanPlayer, ComputerPlayer)
puts "---------------------------------------------------------------------------"
human = HumanPlayer.new(game)
p human.guess_code
# binding.pry
# game.place_player_guess(human, 1)

# puts game.board

# Pseudocode
# 1. ComputerPlayer creates code (Done)
# 2. FOR i = 1 to 12
# 3. HumanPlayer makes a guess (Done)
# 4. IF guess is same as code
# 5. print "Congrats!! You won" and break out of loop
# 6. ELSE get feedback by Computer in the format
#       Red peg:
#       White peg:
#    ENDIF
# 7. ENDFOR
# 8. print "You lost the game."

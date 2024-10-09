require 'pry-byebug'
require_relative 'lib/game'
require_relative 'lib/human_player'
require_relative 'lib/computer_player'

game = Game.new(HumanPlayer, ComputerPlayer)
game.code = ["Red", "Blue", "Green", "Red"]
guess = ["Blue", "Red", "Green", "Green"]

computer = ComputerPlayer.new(game)
computer.print_feedback(guess)
puts "------------------------------------------------------------------"
max_peg_hash = computer.max_peg_count(guess)
p max_peg_hash

red_peg_hash = computer.small_red_peg(guess, max_peg_hash)
p red_peg_hash

white_peg_hash = computer.small_white_peg(red_peg_hash)
p white_peg_hash

p computer.total_white_peg(white_peg_hash)
# Pseudocode
# 1. ComputerPlayer creates code (Done)
# 2. FOR i = 1 to 12
# 3. HumanPlayer makes a guess (Done)
# 4. IF guess is same as code (Done)
# 5. print "Congrats!! You won" and break out of loop (Done)
# 6. ELSE get feedback by Computer in the format
#       Red peg: (Done)
#       White peg: 
#    ENDIF
# 7. ENDFOR
# 8. print "You lost the game." (Done)

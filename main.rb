require_relative 'lib/game'
require_relative 'lib/human_player'
require_relative 'lib/computer_player'

game = Game.new(ComputerPlayer, HumanPlayer)
puts game.current_player
puts game.current_player_id

puts game.opponent_player
puts game.opponent_player_id

# Test for ComputerPlayer create_code method (pass)
com = ComputerPlayer.new(game)
p com.create_code

puts "------------------------------------------------------------------------"
puts game.code



# Pseudocode
# 1. ComputerPlayer creates code (Done)
# 2. FOR i = 1 to 12
# 3. HumanPlayer makes a guess
# 4. IF guess is same as code
# 5. print "Congrats!! You won" and break out of loop
# 6. ELSE get feedback by Computer in the format
#       Red peg:
#       White peg:
#    ENDIF
# 7. ENDFOR
# 8. print "You lost the game."
require_relative 'lib/game'
require_relative 'lib/human_player'
require_relative 'lib/computer_player'

game = Game.new(ComputerPlayer, HumanPlayer)
puts game.current_player
puts game.current_player_id

puts game.opponent_player
puts game.opponent_player_id

require_relative 'lib/game'
require_relative 'lib/human-player'
require_relative 'lib/player'
require_relative 'lib/computer-player'

game = Game.new(HumanPlayer, ComputerPlayer)
puts game.current_player
puts game.opponent_player
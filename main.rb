require_relative "lib/game"
require_relative "lib/human_player"
require_relative "lib/player"
require_relative "lib/computer_player"

game = Game.new(HumanPlayer, ComputerPlayer)
atul = Player.new(game)
p atul.create_code

guddu = HumanPlayer.new(game)
p guddu.guess_code

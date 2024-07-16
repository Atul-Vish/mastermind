# Player should know which game he's playing
class Player
  attr_accessor :pegs

  def initialize(game)
    @game = game
    @pegs = %w[Red Green Blue Yellow Orange Black]
  end
end

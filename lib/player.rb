# Player should know which game he's playing
class Player
  attr_accessor :pegs

  def initialize(game)
    @game = game
    @pegs = %w[Red Green Blue Yellow Orange Black]
  end

  # This method is included in the Player class to allow both Human and Computer to create code
  def create_code
    code = Array.new(4)
    index = 0
    while index < 4
      select_peg = pegs.sample
      code[index] = select_peg

      index += 1
    end

    code
  end
end

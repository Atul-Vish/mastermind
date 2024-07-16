# Player should know which game he's playing
class Player
  def initialize(game)
    @game = game
    @pegs = %w[Red Green Blue Yellow Orange Black]
  end

  def pegs
    @pegs
  end

  def create_code
    code = Array.new(4) # Length of code is 4
    index = 0
    while index < 4
      select_peg = pegs.sample
      code[index] = select_peg

      index += 1
    end

    code
  end
end

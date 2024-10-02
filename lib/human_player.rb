require_relative 'player'

class HumanPlayer < Player
  def initialize(game)
    super(game)
  end

  def to_s
    'Human'
  end

  def create_code; end

  def feedback; end

  def guess_code
		# 1. Call choose colors method
		# 2. Tell user in what format he has to give input (1 2 3 4)
		# 3. Our guess should translate to => Red Blue Green Yellow from our input
		choose_color()
		puts "Enter your guess: "
		input = gets.chomp.split
		guess = Array.new(4)
		input.each_with_index do |val, i|
			index = val.to_i
			peg = pegs[index]
			guess[i] = peg
		end
		guess
	end
end
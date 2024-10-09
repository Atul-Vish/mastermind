require_relative 'player'

class HumanPlayer < Player
  # def initialize(game)
  #   @game = game
  # end

  def to_s
    'Human'
  end

  def create_code; end

  def feedback; end

  def guess_code
		# 1. Provide some basic info about how to make a guess
    choose_color
		# 2. When Player has enters a guess, convert it into integer array
    # "1 2 3 4" => [1, 2, 3, 4]
    guess = gets.chomp.split.map { |val| val.to_i }
		# 3. From integer array convert it into the form : ["Red", "Blue", "Green", "Yellow"]
    # [1, 2, 3, 4] => ["Red", "Blue", "Green", "Yellow"]
    pegs_avail_choices = self.pegs
    # 4. Iterate over guess array and for each number replace it with its corresponding peg
    selection = guess.each_with_index do |value, index|
      num = value
      guess[index] = pegs_avail_choices[num]
    end

    # 5. Return this guess
    selection
	end
end
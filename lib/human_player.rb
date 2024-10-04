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
		# 2. When Player has entered a guess, convert it into integer array
    guess = gets.chomp.split.map { |val| val.to_i }
		# 3. From integer array convert it into the form : ["Red", "Blue", "Green", "Yellow"]
    pegs_avail_choices = self.pegs
    puts pegs_avail_choices
		# 4. Return this guess
	end
end
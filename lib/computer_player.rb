require_relative 'player'

class ComputerPlayer < Player
	attr_accessor :game

	def initialize(game)
		super(game)
	end

	def to_s
		"Computer"
	end

	def create_code
		# 1. Get the pegs array
		choices = pegs
		# 2. Code length is 4, so initialize an array for code
		code = game.code
		i = 0
		# 3. Loop through pegs and for each iteration select a random value and assign it to the code[i]
		while i < 4
			random = choices.sample
			code[i] = random
			i = i + 1
		end
	end

	def feedback
	end

	def guess
	end
end
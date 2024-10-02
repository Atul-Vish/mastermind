require_relative 'player'

class HumanPlayer < Player
	def initialize(game)
		super(game)
	end

	def to_s
		"Human"
	end

	def create_code
	end

	def feedback
	end

	def guess
	end
end
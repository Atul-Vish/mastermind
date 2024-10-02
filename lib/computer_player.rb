require_relative 'player'

class ComputerPlayer < Player
	def initialize(game)
		super(game)
	end

	def to_s
		"Computer"
	end

	def create_code
	end

	def feedback
	end

	def guess
	end
end
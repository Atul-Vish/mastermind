class Player
	attr_accessor :feedback

	def initialize(game)
		@game = game
	end

	def choose_color
		puts "Choose from below pegs:"
		puts "1) Red\n2) Blue\n3) Green\n4) Yellow\n5) Orange\n6) Brown"
	end
end
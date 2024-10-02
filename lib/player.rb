class Player
	attr_reader :pegs

	def initialize(game)
		@game = game
		@pegs = ["Red", "Blue", "Green", "Yellow", "Orange", "Brown"]
	end

	def choose_color
		puts "Choose from below pegs:"
		puts "1) Red\n2) Blue\n3) Green\n4) Yellow\n5) Orange\n6) Brown"
	end
end
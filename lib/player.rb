# Create a Player for our Game
class Player
  attr_reader :pegs

  def initialize(game)
    @game = game
    @pegs = %w[Empty Red Blue Green Yellow Orange Brown]
  end

  def choose_color
    puts 'Choose from below pegs:'
    puts "1) Red\n2) Blue\n3) Green\n4) Yellow\n5) Orange\n6) Brown"
    puts ""
		puts "You have to make your guess in the format specified below."
		puts "If your guess is 'Red Blue Green Yellow' then your input should be '1 2 3 4' separated by spaces"
		puts "Means you have to enter the integer associated with a peg to select that peg."
		puts "---------------------------------------------------------------------------------------------------"
		puts ""
  end
end

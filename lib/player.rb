# Create a Player for our Game
class Player
  attr_reader :pegs, :feedback

  def initialize(game)
    @game = game
    @pegs = %w[Red Blue Green Yellow Orange Brown]
    @feeback = Array.new(2)
  end

  def choose_color
    puts 'Choose from below pegs:'
    puts "0) Red\n1) Blue\n2) Green\n3) Yellow\n4) Orange\n5) Brown"
    puts ""
		puts "You have to make your guess in the format specified below."
		puts "If your guess is 'Red Blue Green Yellow' then your input should be '1 2 3 4' separated by spaces"
		puts "Means you have to enter the integer associated with a peg to select that peg."
		puts "------X-----------X-----------X-----------X--------------X------------X-------------X--------------X------------X------------X-------------X--------"
		puts ""
  end
end

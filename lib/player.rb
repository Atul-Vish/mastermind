# Create a Player for our Game
class Player
  attr_reader :pegs

  def initialize(game)
    @game = game
    @pegs = %w[Red Blue Green Yellow Orange Brown]
  end

  def choose_color
    available_options
    one_line_space
		print_message("If your guess is 'Red Blue Green Yellow' then your input should be '0123'.")
    one_line_space
  end

  def available_options
    print_message("Choose from below pegs:")
    print_message("0) Red\n1) Blue\n2) Green\n3) Yellow\n4) Orange\n5) Brown")
  end

  def print_message(message)
    puts message
  end

  def one_line_space
    puts ""
  end
end

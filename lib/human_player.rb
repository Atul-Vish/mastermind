require_relative "player"

# Inherits from our Base Class
class HumanPlayer < Player
  def guess_code
    puts "Enter your guess separated by spaces"
    gets.chomp.split
  end

  def to_s
    "Human"
  end
end

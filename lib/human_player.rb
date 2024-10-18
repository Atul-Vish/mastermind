require_relative 'player'

# Create a HumanPlayer which can either 'create code' or 'break code'
class HumanPlayer < Player
  attr_accessor :game

  def feedback; end

  def guess_code
    choose_color
    # "1 2 3 4" => [1, 2, 3, 4]
    guess = gets.chomp.split('').map { |val| val.to_i }
    # [1, 2, 3, 4] => ["Red", "Blue", "Green", "Yellow"]
    guess.each_with_index do |integer, index|
      guess[index] = pegs[integer]
    end
  end

  def red_peg_feedback
    print_message("Red pegs: ")
    red_pegs = gets.chomp.to_i
  end

  def white_peg_feedback
    print_message("White Pegs: ")
    white_pegs = gets.chomp.to_i
  end

  def feedback_on_guess
    [red_peg_feedback, white_peg_feedback]
  end

  def to_s
    'Human Player'
  end
end
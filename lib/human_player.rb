require_relative 'player'

# Create a HumanPlayer which can either 'create code' or 'break code'
class HumanPlayer < Player
  attr_accessor :game

  def guess_code
    choose_color
    # "1 2 3 4" => [1, 2, 3, 4]
    guess = take_guess

    guessed_pegs = guess.split('').map { |val| val.to_i }
    # [1, 2, 3, 4] => ["Red", "Blue", "Green", "Yellow"]
    guessed_pegs.each_with_index do |integer, index|
      guessed_pegs[index] = pegs[integer]
    end
  end

  def feedback_on_guess
    [red_peg_feedback, white_peg_feedback]
  end

  def to_s
    'Human Player'
  end



  # All Private methods are below this line
  private

  def take_guess
    guess = 0
    loop do
      guess = gets.chomp
      if is_guess_valid?(guess)
        return guess
      else
        error_message_for_invalid_guess(guess)
      end
    end
  end

  def is_guess_valid?(guess)
    guess.length == 4
  end

  def error_message_for_invalid_guess(guess)
    print_message("Your guess #{guess} is invalid. Please enter a valid guess of size 4 without any spaces in between.")
    one_line_space
  end

  def red_peg_feedback
    print_message("Red pegs: ")
    red_pegs = gets.chomp.to_i
  end

  def white_peg_feedback
    print_message("White Pegs: ")
    white_pegs = gets.chomp.to_i
  end
end
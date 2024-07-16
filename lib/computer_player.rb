require_relative "player"
# Inherits from our Player
class ComputerPlayer < Player
  def provide_feedback_on_guess(guess)
    red_peg = 0
    white_peg = 0
    # Code : Red, Green, Yellow, Blue
    # Guess : Red, Orange, Orange, Orange
    code.each_with_index do |index_of_code, val|
      guess.each_with_index do |index_of_guess, value|
        if index_of_code == index_of_guess && val == value
          red_peg += 1
        elsif index_of_code != index_of_guess && val = value
          white_peg += 1
        end
      end
    end

    puts "Red peg: #{red_peg}"
    puts "White peg: #{white_peg}"
  end

  def to_s
    "Computer"
  end
end

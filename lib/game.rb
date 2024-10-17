# Creates a game board and lets HumanPlayer and ComputerPlayer play against each other
class Game
  attr_accessor :feedback, :code, :board
  attr_reader :current_player_id

  def initialize(player_1_class, player_2_class)
    @players = [player_1_class.new(self), player_2_class.new(self)]
    @board = Array.new(12) { Array.new(4) }
    @code = Array.new(4)
    @feedback = Array.new(12) { Array.new(2) }
    @current_player_id = 0

    puts "#{current_player} goes first!!"
  end

  def play
    code = current_player.create_code
    p code
    guess_no = 1
    while guess_no < 12
      switch_players!
      guess = current_player.guess_code
      place_player_guess_on_board(guess, guess_no)
      p guess

      if has_player_won?(guess)
        print_message(win_message)
        break
      elsif guess_no == 11
        print_message(lose_message)
      end

      switch_players!
      current_player.print_feedback(guess, code)
      guess_no += 1
    end

    print_board
  end

  def print_board
    board.each_with_index do |val, index|
      puts "Your guess #{index + 1} was: #{board[index]}" unless is_slot_empty?(index)
    end
  end

  # All private (implementation) methods are below this
  private

  def current_player
    @players[current_player_id]
  end

  def opponent_player
    @players[opponent_player_id]
  end

  def opponent_player_id
    1 - current_player_id
  end

  def switch_players!
    @current_player_id = 1 - @current_player_id
  end

  def place_player_guess_on_board(guess, guess_no)
    board[guess_no - 1] = guess
  end

  def has_player_won?(player_guess)
    player_guess == code
  end

  def print_message(message)
    puts message
  end

  def win_message
    try_vs_tries = no_of_turns_played > 1 ? "tries" : "try"
    "Congrats!! You won the game in #{no_of_turns_played} #{try_vs_tries}"
  end

  def lose_message
    "You are out of tries!! Better luck next time. The code was #{code}"
  end

  def no_of_turns_left
    12 - no_of_turns_played
  end

  def no_of_turns_played
    board.each_index do |slot_no|
      return slot_no if is_slot_empty?(slot_no)
    end
  end

  # Test Pass
  def is_slot_empty?(slot_no)
    board[slot_no].all? { |peg| peg.nil? }
  end

  def has_player_lost?
    # Yes if he don't have any turns left and given he hasn't won yet, otherwise the game would've ended with a winning message
    no_of_turns_left == 0
  end
end
# Creates a game board and lets HumanPlayer and ComputerPlayer play against each other
class Game
  attr_accessor :feedback, :code, :board, :current_player_id

  def initialize
    @players = [ComputerPlayer.new(self), HumanPlayer.new(self)]
    @board = Array.new(11) { Array.new(4) }
    @code = Array.new(4)
    @feedback = Array.new(11) { Array.new(2) }
    @current_player_id = 0
  end

  def play
    select_your_role
    role = enter_correct_role
    selected_role(role)
  end

  def code_breaker
    self.code = current_player.create_code
    guess_no = 1
    while guess_no < 12
      switch_players!
      guess = current_player.guess_code
      place_player_guess_on_board(guess, guess_no)
      p guess
      one_line_space

      if has_player_won?(guess)
        print_message(win_message)
        break
      end

      switch_players!
      current_player.print_feedback(guess, code)
      print_message(lose_message) if no_of_turns_left.zero?
      guess_no += 1
    end

    print_board
  end

  def print_board
    board.each_with_index do |val, index|
      puts "#{index + 1}. Guess: #{board[index]}" unless is_slot_empty?(index)
    end
  end




  # ALL PRIVATE (IMPLEMENTATION) METHODS ARE BELOW THIS LINE
  private

  def select_your_role
    print_message("Select your role: ")
    print_message("1) Code Breaker")
    print_message("2) Code Creator")
    one_line_space
  end

  def enter_correct_role
    loop do
      print "Enter your choice: "
      role = gets.chomp.to_i
      if is_role_valid?(role)
        return role
      else
        print_message("Incorrect input. Enter either 1 or 2.")
        one_line_space
      end
    end
  end

  def is_role_valid?(role)
    role == 1 || role == 2
  end

  def selected_role(role)
    if role == 1
      code_breaker
    else
      current_player.guess(opponent_player)
    end
  end

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
    "You are out of tries!! Better luck next time. The code was #{code}\n\n"
  end

  def no_of_turns_left
    11 - no_of_turns_played
  end

  def no_of_turns_played
    board.each_index do |slot_no|
      return slot_no if is_slot_empty?(slot_no)
    end

    unless is_slot_empty?(10)
      11
    end
  end

  def is_slot_empty?(slot_no)
    # board[slot_no].all? { |peg| peg.nil? }
    board[slot_no].compact.empty?
  end

  def has_player_lost?
    # Yes if he don't have any turns left and given he hasn't won yet, otherwise the game would've ended with a winning message
    no_of_turns_left == 0
  end

  def one_line_space
    puts ""
  end
end
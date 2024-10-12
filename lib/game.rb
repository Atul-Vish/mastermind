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

  # Problem : Play method is too long, I want to shorten it
  # How will I do it?
  # I will extract some functionality as 'methods' and make those methods private
  # Then I'll call those methods in play method
  def play
    # 1. ComputerPlayer Create Code
    # 2. HumanPlayer Get 12 tries to guess the code
    # 3. If HumanPlayer is able to guess the code in 12 tries THEN
    # 3.1   print "Congrats!! You won the game"
    #   Else print "You lost the game!!"
    current_player.create_code
    p code

    # counter = 0
    # while counter < 12
    #   switch_players!
    #   place_player_guess(current_player, counter)
    #   guess = board[counter]
    #   p guess

    #   try_or_tries = counter.zero? ? "try" : "tries"
    #   if player_has_won?(guess)
    #     message = winning_message + " in #{counter + 1} #{try_or_tries}"
    #     print_message(message)
    #     break
    #   end
    #   switch_players!
    #   current_player.print_feedback(guess)

    #   counter += 1
    # end

    # losing_message
    play_one_exchange
  end

  def play_one_set(no_of_tries)
    counter = 0
    while counter < no_of_tries - 1
      player = current_player
      play_one_exchange(current_player)
    end

    print_message(lose_message)
  end

  # Extract the functionality in which I can pass a number to method as input
  # and I get that many tries to guess the code.
  def play_one_exchange
    guess = current_player.guess_code
    if has_player_won?(guess)
      print_message(win_message)
      return
    else
      current_player.print_feedback(guess)
    end
  end

  def print_board
    board.each_with_index do |val, index|
      puts "Your guess #{index + 1} was #{board[index]}" unless board[index].all? { |value| value.nil? }
    end
  end

  # All private (implementation) methods are below this
  private

  # def current_player
  #   @players[current_player_id]
  # end

  # def opponent_player
  #   @players[opponent_player_id]
  # end

  # def opponent_player_id
  #   1 - current_player_id
  # end

  # def switch_players!
  #   @current_player_id = 1 - @current_player_id
  # end

  def place_player_guess_on_board(player, turn_no)
    guess = player.guess_code
    board[turn_no] = guess
  end

  # # Print winning or Losing message
  # def print_game_end_message(guess)
  #   if player_has_won?(guess)
  #     print_message(win_message)
  #   else
  #     print_message(lose_message)
  #   end
  # end

  def has_player_won?(player_guess)
    player_guess == code
  end

  def print_message(message)
    puts message
  end

  def win_message
    try_vs_tries = if no_of_turns_played > 1 ? "tries" : "try"
    "Congrats!! You won the game in #{no_of_turns_played} #{try_vs_tries}"
  end

  def lose_message
    "You are out of tries!! Better luck next time."
  end

  # Method to calculate no. of turns played (Test pass)
  def no_of_turns_played
    board.each_index do |slot_no|
      return slot_no if is_slot_empty?(board, slot_no)
    end
  end

  def no_of_turns_left
    12 - no_of_turns_played
  end

  # Test Pass
  def is_slot_empty?(slot_no)
    board[slot_no].all? { |peg| peg.nil? }
  end
end
end
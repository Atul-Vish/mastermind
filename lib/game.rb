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

  def place_player_guess(player, try_no)
    # 1. Call player 'guess_code' method and store the guess in a variable
    guess = player.guess_code
    # 2. Place player guess on a board at a specific position
    board[try_no - 1] = guess
  end

  def player_has_won?(guess)
    guess == code
  end

  def winning_message
    "Congrats!! You won the game"
  end

  def losing_message
    "You lost the game!!"
  end

  def print_message(message)
    puts message
  end

  def play
    # 1. ComputerPlayer Create Code
    # 2. HumanPlayer Get 12 tries to guess the code
    # 3. If HumanPlayer is able to guess the code in 12 tries THEN
    # 3.1   print "Congrats!! You won the game"
    #   Else print "You lost the game!!"
    current_player.create_code
    p code

    counter = 0
    while counter < 12
      switch_players!
      guess = current_player.guess_code
      p guess

      try_or_tries = counter.zero? ? "try" : "tries"
      if player_has_won?(guess)
        message = winning_message + " in #{counter + 1} #{try_or_tries}"
        print_message(message)
        break
      end
      switch_players!
      current_player.print_feedback(guess)

      counter += 1
    end

    losing_message
  end
end

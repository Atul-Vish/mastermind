class Game
  attr_accessor :feedback, :code, :board

  def initialize(player_1_class, player_2_class)
    @players = [player_1_class.new(self), player_2_class.new(self)]
    @board = Array.new(12) { Array.new(4) }
    @code = Array.new(4)
    @feedback = Array.new(12) { Array.new(2) }
    @current_player_id = 0

    puts "#{current_player} goes first!!"
  end

  attr_reader :current_player_id

  def current_player
    @players[current_player_id]
  end

  def opponent_player_id
    1 - current_player_id
  end

  def opponent_player
    @players[opponent_player_id]
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

  def winning_message(guess)
    puts "Congrats!! You won the game."
  end

  def losing_message(guess)
    puts "You lost the game!!"
  end
end

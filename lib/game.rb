# Create our board and initialize Players
class Game
  attr_accessor :current_player_id, :code

  def initialize(player_1_class, player_2_class)
    @players = [player_1_class.new(self), player_2_class.new(self)]
    @current_player_id = 0
    @code = Array.new(4) # Length of code is 4
  end

  def opponent_player_id
    1 - @current_player_id
  end

  def current_player
    @players[current_player_id]
  end

  def opponent_player
    @players[opponent_player_id]
  end

  def switch_players
    @current_player_id = opponent_player_id
  end

  # This method is included in the Player class to allow both Human and Computer to create code
  def create_code
    index = 0
    while index < 4
      select_peg = current_player.pegs.sample
      code[index] = select_peg

      index += 1
    end

    code
  end

  def provide_feedback_on_guess(guess)
    red_peg = 0
    white_peg = 0
    index = 0
    while index < 4
      if code[index] == guess[index]
        red_peg += 1
      elsif guess.include?(code[index])
        white_peg += 1
        guess.delete_at(guess.index(code[index]))
      end
      index += 1
    end

    puts "Red peg: #{red_peg}"
    puts "White peg: #{white_peg}"
  end

  def player_has_won?(guess)
    code.eql?(guess)
  end

  def play
    create_code
    switch_players
    index = 0
    while index < 8
      guess = current_player.guess_code
      if player_has_won?(guess)
        puts "#{current_player} has won!! The code was #{code}"
        return
      else
        provide_feedback_on_guess(guess)
        puts "#{7-index} tries left!!"
      end
      switch_players
      switch_players
      index += 1
    end

    puts "You lost the game!! The code was #{code}"
  end
end

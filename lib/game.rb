# Create our board and initialize Players
class Game
  def initialize(player_1_class, player_2_class)
    @players = [player_1_class.new(self), player_2_class.new(self)]
    @current_player_id = 0
  end

  def current_player_id
    @current_player_id
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
end
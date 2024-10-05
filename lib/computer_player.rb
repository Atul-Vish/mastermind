require_relative 'player'

class ComputerPlayer < Player
  attr_accessor :game

  def initialize(game)
    super(game)
  end

  def to_s
    'Computer'
  end

  def create_code
    # 1. Get the pegs array
    choices = pegs
    # 2. Code length is 4, so initialize an array for code
    code = game.code
    i = 0
    # 3. Loop through pegs and for each iteration select a random value and assign it to the code[i]
    while i < 4
      random = choices.sample
      code[i] = random
      i += 1
    end
  end

  def feedback; end

  def guess; end

  # Provide feeback on your guess
  def feedback(guess)
    feedback = Array.new(2) # 0 => small_red_peg, 1 => small_white_peg
    # small_red_peg for correct peg and correct position
    # small_white_peg for correct peg but wrong position
    
    # 1. For small_red_peg check for corresponding pegs in code and guess
    # 2. If same corresponding element then increment the counter by 1
    # 3. For small_white_peg 
    # Code = ["Red", "Blue", "Green", "Yellow"]
    # Guess = ["Yellow", "Blue", "Green", "Red"]
    # 
  end

  def small_red_peg(guess)
    small_red_peg = 0
    # 1. Store the code in a variable
    code = @game.code
    # 2. Check guess against code
    guess.each_with_index do |value, index|
    # 3. If corresponding peg is same in guess and code then increment the small_red_peg count by 1
      if value == code[index]
        small_red_peg += 1
      end
    end
    # 4. Return small_red_peg count
    small_red_peg
  end
end

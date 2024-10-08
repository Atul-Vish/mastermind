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
    feedback = Array.new(2)
    # 1. Calculate max_peg count for a peg
    # 2. Then calculate small_red_peg for this peg
    # 3. Subtract small_red_peg of a peg from max_peg_count
    # 4. Add all the individual small_white_peg count to get the total small_white_peg
    # 5. Add all the individual small_red_peg count to get the total small_red_peg
  end

  def small_red_peg(guess)
    small_red_peg = 0
    # 1. Store the code in a variable
    code = @game.code
    # 2. Check guess against code
    guess.each_with_index do |value, index|
      # 3. If corresponding peg is same in guess and code then increment the small_red_peg count by 1
      small_red_peg += 1 if value == code[index]
    end
    # 4. Return small_red_peg count
    small_red_peg
  end

  def small_white_peg(guess)
    small_white_peg = 0
  end

  def correct_pegs_details(guess)
    # 1. Take guess and convert it into hash using tally
    guess_hash = guess.tally
    # 2. Do the same with code
    code_hash = @code.tally
    # 3. Compare guess and code to find out what pegs are correct and what should be their max_count
    # Example guess_hash = { "Red" => 2, "Blue" => 1, "Yellow" => 1 }
    # code_hash = { "Green" => 1, "Blue" => 1, "Red" => 1, "Brown" => 1 }
    # 3.1 Check If code_hash contains "Red"
    # 3.2 In this case it does contains "Red"
    # 3.3 Then compare their peg_count as : guess_hash ("Red") > code_hash("Red")
    # 3.4 Now, max_peg_count for "Red" will be 2 (same as code count 'always')
    # Iterate over guess_hash and keep repeating the above steps
    # 4. Add this 'max_peg_count' field to the hash and store this value
    # 5. Add 'small_red_peg' and 'small_white_peg' fields too and initially intialize them to 0 for a peg
    # 6. Return this hash
  end

  # Calculate max_peg_count for a peg
  def max_peg_count(guess)
    max_peg_count = 0
    # Convert guess into hash
    guess_hash = guess.tally
    # Convert code into hash
    code_hash = @game.code.tally
    # For each key in guess_hash check if code_hash also contains that key
    max_peg_count_hash = Hash.new { |h, k| h[k] = h.dup.clear }
    guess_hash.each_key do |key|
      next unless code_hash.key?(key)

      max_peg_count = 0
      # { Red => {:max_peg_count => 2} }
      if code_hash[key] > guess_hash[key]
        max_peg_count = guess_hash[key]
      elsif code_hash[key] < guess_hash[key]
        max_peg_count = code_hash[key]
      else
        max_peg_count = code_hash[key]
      end
      max_peg_count_hash[key][:max_peg_count] = max_peg_count
      max_peg_count_hash[key][:small_red_peg] = 0
      max_peg_count_hash[key][:small_white_peg] = 0
    end

    max_peg_count_hash

    # If code_hash also contains that key then compare that key value in code_hash and guess_hash
    # Else move to next peg
    # Initialize a new hash and set max_peg_count for every peg
    # max_peg count will always be equal to code_hash peg value
    # Return this new hash
  end

  def small_red_peg(guess, max_peg_count_hash)
    # 1. If corresponding guess and code pegs are same THEN
    # 2. For that peg 'key' in max_peg_count_hash increase the small_red_peg count by 1
    small_red_peg_hash = max_peg_count_hash
    for i in 0..3
      if guess[i] == @game.code[i]
        small_red_peg_hash[guess[i]][:small_red_peg] += 1
      end
    end

    small_red_peg_hash
  end

  def small_white_peg(small_red_peg_hash)
    small_red_peg_hash.each_key do |key|
      max_peg = small_red_peg_hash[key][:max_peg_count]
      red_peg = small_red_peg_hash[key][:small_red_peg]
      small_red_peg_hash[key][:small_white_peg] = max_peg - red_peg
    end
  end
end

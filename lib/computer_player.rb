require_relative 'player'
# Creates ComputerPlayer to play against 'YOU'
class ComputerPlayer < Player
  attr_accessor :game

  def create_code
    # 1. Get the available choices of pegs
    avail_choices = pegs
    # 2. Store the empty code array in 'code'
    code = game.code
    i = 0
    # 3. Loop through pegs and for each iteration select a random value and assign it to the code[i]
    while i < 4
      random_peg = avail_choices.sample
      code[i] = random_peg
      i += 1
    end
  end

  # Provide feeback on your guess
  def feedback(guess)
    # 1. Calculate max_peg count for a peg
    max_peg_hash = max_peg_count(guess)
    # 2. Then calculate small_red_peg for this peg
    small_red_peg_hash = small_red_peg(guess, max_peg_hash)
    # 3. Subtract small_red_peg of a peg from max_peg_count
    feedback_hash = small_white_peg(small_red_peg_hash)
    # 4. Add all the individual small_white_peg count to get the total small_white_peg
    total_red_peg = total_red_peg(feedback_hash)
    # 5. Add all the individual small_red_peg count to get the total small_red_peg
    total_white_peg = total_white_peg(feedback_hash)

    [total_red_peg, total_white_peg]
  end

  # Calculate max_peg_count for a peg
  def max_peg_count(guess)
    guess_hash = convert_to_hash(guess)
    code_hash = convert_to_hash(game.code)
    feedback_hash = create_nested_infinite_hash

    guess_hash.each_key do |peg|
      next unless code_hash.key?(peg)

      # code_hash[peg] represents count of 'peg' in code. Example code_hash = { "Red" => 2, "Blue" => 2 }
      # code_hash["Red"] = 2
      is_true = code_hash[peg] > guess_hash[peg]
      max_peg_count = is_true ? guess_hash[peg] : code_hash[peg]

      feedback_hash[peg][:max_peg_count] = max_peg_count
      feedback_hash[peg][:small_red_peg] = 0
      feedback_hash[peg][:small_white_peg] = 0
    end

    feedback_hash
  end

  # Converts code = ["Red", "Blue", "Red", "Yellow"] to { "Red" => 2, "Blue" => 1, "Yellow" => 1}
  def convert_to_hash(array)
    array.tally
  end

  # Creates nested hash with infinite depth
  def create_nested_infinite_hash
    Hash.new { |h, k| h[k] = h.dup.clear }
  end

  def small_red_peg(guess, feedback_hash)
    # Check corresponding peg in code and guess and if they are same THEN
    #  increase the small_red_peg count for that peg by 1
    guess.each_with_index do |peg, index|
      feedback_hash[peg][:small_red_peg] += 1 if peg == game.code[index]
    end

    feedback_hash
  end

  def small_white_peg(feedback_hash)
    feedback_hash.each_key do |peg|
      max_peg = feedback_hash[peg][:max_peg_count]
      red_peg = feedback_hash[peg][:small_red_peg]
      feedback_hash[peg][:small_white_peg] = max_peg - red_peg
    end
  end

  def total_red_peg(feedback_hash)
    tot_red_peg = 0
    feedback_hash.each_key do |key|
      tot_red_peg += feedback_hash[key][:small_red_peg]
    end

    tot_red_peg
  end

  def total_white_peg(feedback_hash)
    tot_white_peg = 0
    feedback_hash.each_key do |peg|
      tot_white_peg += feedback_hash[peg][:small_white_peg]
    end

    tot_white_peg
  end

  def print_feedback(guess)
    array = feedback(guess)
    red_pegs = array[0]
    white_pegs = array[1]

    puts "\tRed pegs: #{red_pegs}"
    puts "\tWhite pegs: #{white_pegs}"
    puts ""
  end

  def to_s
    'Computer'
  end
end

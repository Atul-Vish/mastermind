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
    game.switch_players!
    code
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

  # Converts code = ["Red", "Blue", "Red", "Yellow"] to { "Red" => 2, "Blue" => 1, "Yellow" => 1}
  def convert_to_hash(array)
    array.tally
  end

  # Creates nested hash with infinite depth
  def create_nested_infinite_hash
    Hash.new { |h, k| h[k] = h.dup.clear }
  end

  def print_feedback(guess)
    array = feedback(guess)
    red_pegs = array[0]
    white_pegs = array[1]

    game.switch_players!
    puts "\tRed pegs: #{red_pegs}"
    puts "\tWhite pegs: #{white_pegs}"
    puts ""
  end

  # Implement Minimax algorithm for Computer to make guesses
  def guess
    # 3. Get feedback on your initial guess
    # 4. If the feedback is all colored pegs then algorithm terminates (let's skip this for now)
    # 5. Iterate over sample, considering each sample[i] as code and play '1122' against it
    #     If feedback you get is same as (3) then include it otherwise remove sample[i] from set
  end

  # 1, Create set 'S' of all possible 1296 codes
  def create_set_of_all_possible_codes
    pegs.repeated_permutation(4).to_a
  end

  # 2. Select initial guess 1122 eq to [Red Red Blue Blue]
  def select_initial_guess
    %w[Red Red Blue Blue]
  end

  # 3. Get feedback on your guess from HumanPlayer
  def take_feedback_on_guess
    puts "Red Pegs: "
    red_pegs = gets.chomp.to_i

    puts "White Pegs: "
    white_pegs = gets.chomp.to_i

    [red_pegs, white_pegs]
  end

  # 5. Eliminating codes from sample that couldn't possibly be our answer (the real code)
  def remove_codes_from_set(guess, set)
    # 1. Iterate over set such that every element in set could be possible code
    sample = set
    recent_guess = guess
    feedback_on_recent_guess = take_feedback_on_guess
    sample.each do |possible_code|
      feedback_on_possible_code = feedback(possible_code, recent_guess)

      if feedback_on_possible_code == feedback_on_recent_guess
        p feedback_on_possible_code
        # set.delete(possible_code)
      else
        sample.delete(possible_code)
      end
    end

    return sample
    # 2. Against this code play your initial guess '1122' and you should get the same feedback if it was code
    # 3. If you get the same feedback it means it can possibly be the answer so keep it
    # 4. Otherwise remove it from the set if the feedback you got is different than what you got for '1122'
    # 5. Return this new set after removing all values which can't possibly be our code
  end

  def to_s
    'Computer'
  end
end

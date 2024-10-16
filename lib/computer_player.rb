require 'pry-byebug'
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

    code
  end

  # Provide feeback on your guess
  def feedback(guess, code)
    # 1. Calculate max_peg count for a peg
    max_peg_hash = max_peg_count(guess, code)
    # 2. Then calculate small_red_peg for this peg
    small_red_peg_hash = small_red_peg(guess, code, max_peg_hash)
    # 3. Subtract small_red_peg of a peg from max_peg_count
    feedback_hash = small_white_peg(small_red_peg_hash)
    # 4. Add all the individual small_white_peg count to get the total small_white_peg
    total_red_peg = total_red_peg(feedback_hash)
    # 5. Add all the individual small_red_peg count to get the total small_red_peg
    total_white_peg = total_white_peg(feedback_hash)

    [total_red_peg, total_white_peg]
  end

  # Calculate max_peg_count for a peg
  def max_peg_count(guess, code)
    guess_hash = convert_to_hash(guess)
    # code_hash = convert_to_hash(game.code)
    code_hash = convert_to_hash(code)
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

  def small_red_peg(guess, code, feedback_hash)
    # Check corresponding peg in code and guess and if they are same THEN
    #  increase the small_red_peg count for that peg by 1
    guess.each_with_index do |peg, index|
      feedback_hash[peg][:small_red_peg] += 1 if peg == code[index]
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

  def print_feedback(guess, code)
    array = feedback(guess, code)
    red_pegs = array[0]
    white_pegs = array[1]

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
    initial_guess = select_initial_guess
    p initial_guess
    feedback = feedback_on_guess
    sample = create_set_of_all_possible_codes

    sample_modified = remove_codes_from_sample(initial_guess, feedback, sample)
    # 10 more guesses for Computer
    counter = 0
    while counter < 10
      score_array = score_array(sample_modified)
      guess =  guess_to_play_next(sample_modified, score_array)
      p guess
      feedback1 = feedback_on_guess
      if feedback1 == [4, 0]
        puts "You won the game in #{counter + 1} tries."
        break
      end
      sample_modified = remove_codes_from_sample(guess, feedback1, sample_modified)
      counter += 1
    end
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
  def red_peg_feedback
    puts "Red pegs: "
    red_pegs = gets.chomp.to_i
  end

  def white_peg_feedback
    puts "White Pegs: "
    white_pegs = gets.chomp.to_i
  end

  def feedback_on_guess
    [red_peg_feedback, white_peg_feedback]
  end

  # 5. Eliminating codes from sample that couldn't possibly be our answer (the real code) TEST PASS
  def remove_codes_from_sample(guess, feedback_on_guess, sample)
    # 1. Iterate over set such that every element in set could be possible code
    modified_sample = Array.new
    sample.each do |possible_code|
      feedback_on_possible_code = feedback(guess, possible_code)

      modified_sample << possible_code if feedback_on_possible_code == feedback_on_guess
    end

    modified_sample
  end

  # 1. Consider the first code in modified_sample as guess and other codes as codes
  # and take feedback and group them
  def feedback_hash_for_score(guess, set)
    hash = Hash.new
    set.each do |possible_code|
      feedback = feedback(guess, possible_code)
      # if possible_code == guess && set.size == 1
      #   hash[feedback] = 0
      # end

      if hash.key?(feedback)
        hash[feedback] += 1
      elsif 
        hash[feedback] = 1
      end
    end

    hash
  end

  # 2. Assign score to the guess
  def assign_score(hash)
    hash.values.max
  end

  # Return the score array
  def score_array(set)
    score_array = Array.new(set.size)
    set.each_with_index do |code, index|
      feedback_hash = feedback_hash_for_score(code, set)
      max_value = feedback_hash.values.max
      score = set.size - max_value
      score_array[index] = score
    end

    score_array
  end

  def guess_to_play_next(set, score_array)
    max_score = score_array.max
    index = score_array.find_index(max_score)

    set[index]
  end

  def to_s
    'Computer'
  end
end

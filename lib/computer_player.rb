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
    feedback = feedback_on_guess
    sample = create_set_of_all_possible_codes

    puts "------------------x------------------x----------------------x-----------------------x"
    sample_modified = remove_codes_from_sample(initial_guess, feedback, sample)
    sample_modified.each { |val| p val }
    # Code is fine upto this point
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

  # 5. Eliminating codes from sample that couldn't possibly be our answer (the real code)
  def remove_codes_from_sample(guess, feedback_on_guess, sample)
    # 1. Iterate over set such that every element in set could be possible code
    remove_from_sample = Array.new
    sample.each do |possible_code|
      feedback_on_possible_code = feedback(guess, possible_code)

      if feedback_on_possible_code == feedback_on_guess
        remove_from_sample << possible_code
      end
    end

    remove_from_sample
  end

  def to_s
    'Computer'
  end
end

require_relative 'player'
# Creates ComputerPlayer to play against 'YOU'
class ComputerPlayer < Player
  attr_accessor :game

  def create_code
    avail_choices = pegs
    code = Array.new(4)

    code.each_index do |index|
      random_peg = avail_choices.sample
      code[index] = random_peg
    end
  end

  def print_feedback(guess, code)
    array = provide_feedback(guess, code)
    red_pegs = array[0]
    white_pegs = array[1]

    print_message("\tRed pegs: #{red_pegs}")
    print_message("\tWhite pegs: #{white_pegs}")
    print_message("------X-----------X-----------X-----------X-----------X------------X-------------X--------------X------------X------------X-------------X-----------X-----------X-----------X-----------X-----------X")
    one_line_space
  end

  # Implement Minimax algorithm for Computer to make guesses
  def guess(player)
    do_it_first
    initial_guess = select_initial_guess
    p initial_guess
    feedback = player.feedback_on_guess
    sample = create_set_of_all_possible_codes

    sample_modified = remove_codes_from_sample(initial_guess, feedback, sample)
    # 10 more guesses for Computer
    counter = 0
    while counter < 10
      score_array = score_array(sample_modified)
      guess =  guess_to_play_next(sample_modified, score_array)
      print_message("")
      p guess
      feedback1 = player.feedback_on_guess
      if feedback1 == [4, 0]
        print_message("#{self} won the game in #{counter + 2} tries.")
        break
      end
      sample_modified = remove_codes_from_sample(guess, feedback1, sample_modified)
      counter += 1
    end
  end

  def do_it_first
    print_message("Create a code with 4 Pegs (out of 6)")
    print_message("Write this code on paper & Provide me feedback on my guesses.")
    one_line_space
  end

  def to_s
    'Computer Player'
  end




  # All Private methods are below
  private

  def provide_feedback(guess, code)
    max_peg_hash = max_peg_count(guess, code)
    small_red_peg_hash = small_red_peg(guess, code, max_peg_hash)
    feedback_hash = small_white_peg(small_red_peg_hash)
    feedback_red = total_red_peg(feedback_hash)
    feedback_white = total_white_peg(feedback_hash)

    [feedback_red, feedback_white]
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

  # Converts code = ["Red", "Blue", "Red", "Yellow"] to { "Red" => 2, "Blue" => 1, "Yellow" => 1}
  def convert_to_hash(array)
    array.tally
  end

  # Creates nested hash with infinite depth
  def create_nested_infinite_hash
    Hash.new { |h, k| h[k] = h.dup.clear }
  end

  def small_red_peg(guess, code, feedback_hash)
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

  def select_initial_guess
    %w[Red Red Blue Blue]
  end

  def create_set_of_all_possible_codes
    pegs.repeated_permutation(4).to_a
  end

  # 5. Eliminating codes from sample that couldn't possibly be our answer (the real code) TEST PASS
  def remove_codes_from_sample(guess, feedback_on_guess, sample)
    # 1. Iterate over set such that every element in set could be possible code
    modified_sample = Array.new
    sample.each do |possible_code|
      feedback_on_possible_code = provide_feedback(guess, possible_code)

      modified_sample << possible_code if feedback_on_possible_code == feedback_on_guess
    end

    modified_sample
  end

  # Return the score array
  def score_array(set)
    score_array = Array.new(set.size)
    set.each_with_index do |code, index|
      feedback_hash = feedback_hash_for_score(code, set)
      max_value = assign_max_value(feedback_hash)
      score = set.size - max_value
      score_array[index] = score
    end

    score_array
  end

  # 2. Assign score to the guess
  def assign_max_value(hash)
    hash.values.max
  end

  # 1. Consider the first code in modified_sample as guess and other codes as codes
  # and take feedback and group them
  def feedback_hash_for_score(guess, set)
    hash = Hash.new
    set.each do |possible_code|
      feedback = provide_feedback(guess, possible_code)

      if hash.key?(feedback)
        hash[feedback] += 1
      elsif 
        hash[feedback] = 1
      end
    end

    hash
  end

  def guess_to_play_next(set, score_array)
    max_score = score_array.max
    index = score_array.find_index(max_score)

    set[index]
  end
end

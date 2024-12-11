def read_input(input_file)
  lines = File.readlines(input_file).map do |line|
    line.chomp.chars
  end
  lines
end

def count_word(input, word, test_mode)
  count = 0

  count += count_horizontal_matches(input, word, test_mode)
  count += count_horizontal_matches(input, word.reverse, test_mode)

  # transpose the array to count vertical matches
  transposed_input = input.transpose

  count += count_horizontal_matches(transposed_input, word, test_mode)
  count += count_horizontal_matches(transposed_input, word.reverse, test_mode)

  diagonals = diagonals_both_directions(input)

  puts "LTR diagonals: #{diagonals[:left_to_right]}" if test_mode
  count += count_horizontal_matches(diagonals[:left_to_right], word, test_mode)
  count += count_horizontal_matches(diagonals[:left_to_right], word.reverse, test_mode)

  puts "RTL diagonals: #{diagonals[:right_to_left]}" if test_mode
  count += count_horizontal_matches(diagonals[:right_to_left], word, test_mode)
  count += count_horizontal_matches(diagonals[:right_to_left], word.reverse, test_mode)

  return count
end

def diagonals_both_directions(array)
  diagonals_lr = [] # Top-left to bottom-right diagonals
  diagonals_rl = [] # Top-right to bottom-left diagonals

  # Top-left to bottom-right diagonals (left-to-right)
  array.each_with_index do |row, i|
    row.each_with_index do |element, j|
      diagonals_lr[i + j] ||= []       # Ensure the diagonal array exists
      diagonals_lr[i + j] << element   # Add the element to the appropriate diagonal
    end
  end

  # Top-right to bottom-left diagonals (right-to-left)
  array.each_with_index do |row, i|
    row.each_with_index do |element, j|
      diagonals_rl[i - j + (array[0].size - 1)] ||= [] # Offset to avoid negative index
      diagonals_rl[i - j + (array[0].size - 1)] << element
    end
  end

  { left_to_right: diagonals_lr, right_to_left: diagonals_rl }
end

def count_horizontal_matches(input, word, test_mode)
  count = 0
  regex = /#{Regexp.escape(word)}/

  input.each do |line|
    joined_string = line.join
    local_count = joined_string.scan(regex).size
    # puts "Counted #{word} #{local_count} time(s) in line: #{joined_string}" if test_mode
    count += local_count
  end
  return count
end

def count_x_mas(input, test_mode)
  count = 0

  center_as = find_center_a_indexes(input, test_mode)

  center_as.each_with_index do |line, i|
    line.each do |a_idx|
      puts "A found on row #{i+1}, column: #{a_idx}" if test_mode

      ltr_chars = [input[i][a_idx-1], input[i+2][a_idx+1]]
      rtl_chars = [input[i][a_idx+1], input[i+2][a_idx-1]]

      puts "LTR: #{ltr_chars}" if test_mode
      puts "RTL: #{rtl_chars}" if test_mode


      if matches_mas?(ltr_chars) && matches_mas?(rtl_chars)
        puts "We have a match!" if test_mode
        count += 1
      end

    end
  end

  return count
end

def matches_mas?(array)
  [['S', 'M'], ['M', 'S']].include?(array)
end

def find_center_a_indexes(input, test_mode)
  indexes = []
  input.each_with_index do |line, idx|
    # to start, just count A's on inner lines
    next if idx == 0 or idx == input.length - 1
    indexes << line[1...-1].each_with_index
               .select { |element, index| element == 'A' }
               .map { |pair| pair[1] + 1 }
  end
  indexes
end

def four_a(input_file, test_mode = true)
  puts count_word(read_input(input_file),'XMAS', test_mode)
end


# puts four_a('4input', false)

def four_b(input_file, test_mode = true)
  puts count_x_mas(read_input(input_file), test_mode)
end

puts four_b('4input', false)
def read_input(input_file)
  lines = IO.readlines(input_file)
  return lines.join
end

def get_matches(input)
  matches = input.scan(/mul\((\d{1,3}),(\d{1,3})\)/)
end

def read_conditionals(input)
  regex = /do\(\)|don't\(\)/

  matches = input.enum_for(:scan, regex).map do
    match = Regexp.last_match
    { match: match[0], index: match.begin(0) }
  end

  matches
end

def parse_instructions(matches)
  sum = 0
  matches.each do |x, y|
    # puts "x: #{x}, y: #{y}"
    sum += x.to_i * y.to_i
  end
  sum
end



def three_a(input_file)
  puts parse_instructions(get_matches(read_input(input_file)))
end

def three_b(input_file, test_mode = false)
  input = read_input(input_file)
  conditionals = read_conditionals(input)
  sum = 0

  starting_idx = 0
  current_state = true

  conditionals.each do |conditional|
    if current_state
      # keep going if this is a do match since we are already enabled.
      next if conditional[:match] == "do()"
      puts "Sum the following instructions: #{input[starting_idx..conditional[:index] - 1]}" if test_mode

      local_sum = parse_instructions(get_matches(input[starting_idx..conditional[:index] - 1]))
      puts "Adding #{local_sum}" if test_mode

      sum += local_sum
      current_state = false
    else
      next if conditional[:match] == "don't()"
      current_state = true
      puts "Start looking for instructions to parse from #{conditional[:index]}" if test_mode
      starting_idx = conditional[:index]
    end
  end

  if current_state
    # parse the final set of instructions if the last conditional was do()
    puts "Sum the following instructions: #{input[starting_idx..input.length-1]}" if test_mode

    local_sum = parse_instructions(get_matches(input[starting_idx..input.length - 1]))
    puts "Adding #{local_sum}" if test_mode

    sum += local_sum
  end

  return sum
end

puts three_b('3input')
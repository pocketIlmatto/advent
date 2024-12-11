def read_input(input_file)
  lines = IO.readlines(input_file)
  return lines.join
end

def get_matches(input)
  matches = input.scan(/mul\((\d{1,3}),(\d{1,3})\)/)
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

three_a('3input')
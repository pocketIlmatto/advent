def split_file_sections(file_path)
  # Read all lines and split the file into sections using an empty line as the delimiter
  top_section, bottom_section = File.read(file_path).split("\n\n", 2)

  # Split the lines into arrays
  {
    top_section: top_section.split("\n"),
    bottom_section: bottom_section ? bottom_section.split("\n") : []
  }
end

def build_rules_hash(rules_array, test_mode)
  rules = {}


  rules_array.each do |rule|
    # puts "Processing rule: #{rule}" if test_mode
    a, b = rule.split('|')

    rules[a] ||= {before: [], after: []}
    rules[a][:before] << b
    # puts "Rules for #{a}: #{rules[a]}" if test_mode


    rules[b] ||= {before: [], after: []}
    rules[b][:after] << a
    # puts "Rules for #{b}: #{rules[b]}" if test_mode
  end
  # puts rules.inspect if test_mode
  rules
end

def check_updates(updates, rules_hash, test_mode)
  middle_page_sum = 0

  updates.each do |update|
    (0..update.length-1).each do |i|
      pages_before = update[0..i]
      pages_after = update[i+1..update.length-1]


    end

  end

  middle_page_sum
end

def five_a(input_file, test_mode = true)
  result = split_file_sections(input_file)
  build_rules_hash(result[:top_section], test_mode)
  puts check_updates(result[:bottom_section], test_mode)
end

five_a('5testInput')
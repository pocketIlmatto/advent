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
    puts "Processing rule: #{rule}" if test_mode
    a, b = rule.split('|')

    rules[a] ||= {before: [], after: []}
    rules[a][:before] << b


    rules[b] ||= {before: [], after: []}
    rules[b][:after] << a
  end
  rules
end

def check_updates(updates, rules_hash, test_mode)
  middle_page_sum = 0

  updates.each do |update|
    update_pages = update.split(',')
    is_update_legal = true


    (0..update_pages.length-1).each do |i|
      current_page = update_pages[i]
      pages_before = update_pages[0..i]
      pages_after = update_pages[i+1..update_pages.length-1]

      illegal_before_pages = pages_before.intersection(rules_hash[current_page][:before])
      if illegal_before_pages.length > 0
        puts "Update #{update_pages}, page #{current_page} breaks a rule: #{illegal_before_pages} should not come before #{current_page}" if test_mode
        is_update_legal = false
      end

      illegal_after_pages = pages_after.intersection(rules_hash[current_page][:after])
      if illegal_after_pages.length > 0
        puts "Update #{update_pages}, page #{current_page} breaks a rule: #{illegal_after_pages} should not come after #{current_page}" if test_mode
        is_update_legal = false
      end
    end

    if is_update_legal
      middle_page = update_pages[(update_pages.length-1)/2].to_i
      puts "Adding middle page (#{middle_page} of this update: #{update_pages}" if test_mode
      middle_page_sum += middle_page
    end
    is_update_legal = true
  end

  middle_page_sum
end

def five_a(input_file, test_mode = true)
  result = split_file_sections(input_file)
  rules_hash = build_rules_hash(result[:top_section], test_mode)
  puts check_updates(result[:bottom_section], rules_hash, test_mode)
end

five_a('5input', true)
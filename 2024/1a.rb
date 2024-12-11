
def get_lists(input_file)
  list_a = []
  list_b = []

  File.readlines(input_file).each do |line|
    tokens = line.split(' ')
    list_a << tokens[0].to_i
    list_b << tokens[1].to_i
  end
  [list_a, list_b]
end

def get_distance(list_a, list_b)
  list_a.sort!
  list_b.sort!

  distance_sum = 0

  list_a.each_with_index do |loc, i|
    distance_sum += (loc - list_b[i]).abs
  end

  distance_sum
end

def one_a(input_file)
  lists = get_lists(input_file)
  list_a = lists[0]
  list_b = lists[1]
  puts get_distance(list_a, list_b)
end


def get_similarity(list_a, list_b)

  list_a.sort!
  list_b.sort!

  similarity = 0
  list_b_idx = 0
  prev_a = nil
  local_similarity = 0
  list_b_match_count = 0

  list_a.each do |loc_a|
    puts "Checking #{loc_a}, prev_a = #{prev_a}"
    if loc_a == prev_a && local_similarity != 0
      similarity += local_similarity
      puts "Adding #{local_similarity} since #{loc_a} == #{prev_a}"
    else
      local_similarity = 0
      list_b_match_count = 0

      while list_b_idx < list_b.length
        if list_b[list_b_idx] == loc_a
          # while elements in list b = current element in list a, increase counter & index iterator
          list_b_match_count += 1
          list_b_idx += 1
          puts "Counting another match from list b, count now at #{list_b_match_count}"
        elsif list_b[list_b_idx] < loc_a
          list_b_idx += 1
        else
          # once we get to element in b that doesn't match current element a, break out
          break
        end
      end
      puts "List b idx: #{list_b_idx}"
      if list_b_match_count > 0
        local_similarity = list_b_match_count * loc_a
        puts "Adding #{local_similarity} to sum, for #{list_b_match_count} * #{loc_a}"
        similarity += local_similarity
      end
    end
    prev_a = loc_a
  end
  puts "#{similarity}"
end

def one_b(input_file)
  lists = get_lists(input_file)
  list_a = lists[0]
  list_b = lists[1]
  puts get_similarity(list_a, list_b)
end


# one_a('1input')

one_b('1input')
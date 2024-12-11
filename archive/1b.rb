require 'set'
# find the three entries that sum to 2020 and then multiply those two numbers together
SUM = 2020
history = {}

def find_three_sum(sum, list)
  list.each_with_index do |line, i|
    two_sum = find_two_sum((SUM - line), list[i+1..-1])
    if two_sum
      return two_sum + [line]
    end
  end
end

def find_two_sum(sum, list)
  history = Set.new

  list.each do |line|
    if history.include?(sum - line)
      return [(sum - line), line]
    else
      history << line
    end
  end
  return nil
end

three_sum = find_three_sum(SUM, File.readlines('1-input').map{ |x| x.to_i })
puts three_sum
puts three_sum.inject(:*)

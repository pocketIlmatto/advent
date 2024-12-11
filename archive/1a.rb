require 'set'
# find the two entries that sum to 2020 and then multiply those two numbers together
SUM = 2020
history = Set.new

File.readlines('1-input').map{ |x| x.to_i }.each do |line|
  if history.include?(SUM - line)
    puts (SUM - line) * line
  else
    history << line
  end
end

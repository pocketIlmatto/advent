

def valid_passport(passport)
  require_keys = ['byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid']
  (require_keys - passport).size == 0
end



valid_count = 0
current_passport = []
File.readlines('4-input', chomp: true).each do |line|
  if line.size == 0
    valid_count += 1 if valid_passport(current_passport.flatten)
    puts "Valid count as of #{current_passport.flatten}: #{valid_count}"
    current_passport = []
    next
  end
  current_passport << line.split(' ').map { |x| x.split(':')[0]}
end

puts valid_count
# find number of valid passwords

# Format: a-b c: xxxxxx
# letter c must appear in exactly one of these positions (not zero indexed)
# c: the letter
# xxxxxx: the password
# eg:
# 5-7 f: fffffffh

def is_valid?(min, max, letter, password)
  (password[min - 1] == letter) ^ (password[max - 1] == letter)
end

valid_count = 0

File.readlines('2-input').each do |line|
  tokens = line.split(' ')
  min = tokens[0].split('-')[0].to_i
  max = tokens[0].split('-')[1].to_i
  letter = tokens[1].gsub(':', '')
  password = tokens[2]
  if is_valid?(min, max, letter, password)
    valid_count += 1
    puts "line #{line} seems valid"
  end
end



puts valid_count
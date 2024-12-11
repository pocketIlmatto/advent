# find number of valid passwords

# Format: a-b c: xxxxxx
# a: min number of times the letter should appear
# b: max number of times the letter should appear
# c: the letter
# xxxxxx: the password
# eg:
# 5-7 f: fffffffh

def is_valid?(min, max, letter, password)
  letter_count = 0
  password.split('').each do |c|
    letter_count += 1 if c == letter
  end
  return letter_count >= min && letter_count <= max
end

valid_count = 0

File.readlines('2-input').each do |line|
  tokens = line.split(' ')
  min = tokens[0].split('-')[0].to_i
  max = tokens[0].split('-')[1].to_i
  letter = tokens[1].gsub(':', '')
  password = tokens[2]
  valid_count += 1 if is_valid?(min, max, letter, password)
end



puts valid_count
def get_reports(input_file)
  reports = []

  File.readlines(input_file).each do |line|
    levels = line.split(' ').map {|level| level.to_i }
    reports << levels
  end
  reports
end

def is_safe?(report, test_mode = false)
  prev_level = nil
  # will set this to 1 if increasing, 2 if decreasing
  delta_direction = 0
  report.each do |level|
    puts "level #{level}, prev_level #{prev_level}" if test_mode
    if prev_level
      # not safe if delta between 2 adjacent levels is > 3
      diff = (level - prev_level).abs
      if diff == 0 || diff > 3
        puts "not safe because diff #{diff}" if test_mode
        return false
      end

      if delta_direction == 0
        # if delta_direction is 0, set it
        if prev_level < level
          puts "Setting direction to increasing" if test_mode
          delta_direction = 1
        elsif prev_level > level
          puts "Setting direction to decreasing" if test_mode
          delta_direction = 2
        end
      elsif delta_direction == 1
        # if delta_direction is 1, only increasing levels are ok
        if prev_level >= level
          puts "not safe because #{prev_level} >= #{level} and we are already increasing" if test_mode
          return false
        end

      elsif delta_direction == 2
        # if delta_direction is 2, only decreasing levels are ok
        if prev_level <= level
          puts "not safe because #{prev_level} <= #{level} and we are already decreasing" if test_mode
          return false
        end
      end

    end

    prev_level = level
  end

  puts "Report #{report} is safe" if test_mode
  return true
end

def safe_with_problem_dampener?(report, test_mode)
  puts "Applying problem dampener to #{report}" if test_mode
  (0..report.length - 1).each do |i|
    sub_report = report.map(&:dup)
    sub_report.delete_at(i)
    if is_safe?(sub_report)
      puts "sub report #{sub_report} is safe" if test_mode
      return true
    else
      puts "sub report #{sub_report} is not safe" if test_mode
    end
  end
  return false
end


def count_safe_reports(reports, try_problem_dampener = false, test_mode = false)
  sum = 0
  reports.each do |report|
     puts "Checking report #{report}" if test_mode
    if is_safe?(report, test_mode)
      sum += 1
    else
      if try_problem_dampener
        sum += 1 if safe_with_problem_dampener?(report, test_mode)
      end
    end
  end
  return sum
end

def two_a(input_file)
  reports = get_reports(input_file)
  puts count_safe_reports(reports, false, false)
end

def two_b(input_file)
  reports = get_reports(input_file)
  puts count_safe_reports(reports, true, false)
end




two_b('2input')
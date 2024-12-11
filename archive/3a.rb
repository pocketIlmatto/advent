def tree?(grid, location)
  # puts "Checking #{location}: #{grid[location[1]][location[0]]}"
  grid[location[1]][location[0]] == '#'
end

def move_next(grid, location, slope)
  x = location[0] + slope[0]
  y = location[1] + slope[1]
  # puts "#{x}, #{y}"
  if y >= grid.size
    # puts "Reached bottom!"
    return nil
  end
  if x >= grid[y].size
    # puts "Wrapping back around from #{x} to #{x - grid[y].size}"
    x = x - grid[y].size
  end
  return [x, y]
end

def make_grid
  grid = []
  File.readlines('3-input', chomp: true).each do |line|
    grid << line.split('')
  end
  grid
end

def count_trees(grid, slope)
  current = [0, 0]

  tree_count = 0

  loop do
    tree_count += 1 if tree?(grid, current)
    # puts "Tree count as of #{current}: #{tree_count}"
    current = move_next(grid, current, slope)

    # break if tree_count > 2
    break if current == nil
  end
  return tree_count
end

grid = make_grid
tree_counts = []
tree_counts << count_trees(grid, [1, 1])
tree_counts << count_trees(grid, [3, 1])
tree_counts << count_trees(grid, [5, 1])
tree_counts << count_trees(grid, [7, 1])
tree_counts << count_trees(grid, [1, 2])
puts tree_counts.inject(:*)



# rows = File.readlines("3-input", chomp: true)
# rows.shift

# trees = rows.each.with_index(1).count { |row, y| row[y * 3 % row.size] == "#" }

# puts trees



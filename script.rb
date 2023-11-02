# frozen_string_literal: true

# player to play tic tac toe
class Player
  attr_accessor :mark

  def initialize(mark)
    @mark = mark
  end
end

# grid to play tic tac toe on
class Grid
  attr_accessor :spaces

  def initialize
    @spaces = []
    9.times do |i|
      space = Space.new(i + 1, i + 1)
      @spaces << space
    end
  end

  def print_grid
    puts '           '
    @spaces.each do |space|
      if space.id % 3 != 0
        print " #{space.value} |"
      else
        puts " #{space.value} "
        puts '———+———+———' if space.id != 9
      end
    end
    puts '           '
  end
end

# a single space within the grid
class Space
  attr_accessor :value
  attr_reader :id

  def initialize(id, value)
    @id = id
    @value = value
  end
end

puts 'Welcome to Tic Tac Toe'
puts 'X goes first'

grid = Grid.new
grid.print_grid

player1 = Player.new('X')
player2 = Player.new('O')

def make_move(grid, id, player, counter)
  count = counter
  if grid.spaces[id - 1].value == 'X' || grid.spaces[id - 1].value == 'O'
    print "#{id} is taken, pick a different number: "
    count -= 1
    return count
  end

  grid.spaces[id - 1] = Space.new(id, player.mark)
  count
end

def winner(arr)
  a = []
  arr.each do |item|
    a << item.value
  end

  return a[0] if a[0] == a[1] && a[1] == a[2]
  return a[3] if a[3] == a[4] && a[4] == a[5]
  return a[6] if a[6] == a[7] && a[7] == a[8]
  return a[0] if a[0] == a[3] && a[3] == a[6]
  return a[1] if a[1] == a[4] && a[4] == a[7]
  return a[2] if a[2] == a[5] && a[5] == a[8]
  return a[0] if a[0] == a[4] && a[4] == a[8]
  return a[2] if a[2] == a[4] && a[4] == a[6]
end

def tie?(arr)
  arr.each do |item|
    return false if item.value != 'X' && item.value != 'O'
  end
  true
end

def game_over?(grid)
  arr = grid.spaces

  if winner(arr) == 'X' || winner(arr) == 'O'
    puts "#{winner(arr)} wins!"
    return true
  end

  if tie?(arr)
    puts 'No winner, tie.'
    return true
  end

  false
end

counter = 1
should_print = true

while game_over?(grid) == false
  player = (counter % 2).zero? ? player2 : player1
  print 'Choose a number to mark: ' if should_print
  id = gets.chomp.to_i
  old_count = counter
  counter = make_move(grid, id, player, counter)
  should_print = false
  if counter == old_count
    grid.print_grid
    should_print = true
  end
  counter += 1
end

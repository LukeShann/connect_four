# frozen_string_literal: true

DIRECTIONAL_PAIRS = [[[0, 1],[0, -1]], [[1, 1],
  [-1, -1]], [[1, 0], [-1, 0]], [[-1, 1], [1, -1]]]

class Board
  attr_accessor :state

  def initialize(game)
    @state = Array.new(7, Array.new(6, 0))
    @game = game
  end

  # purely printing function, no testing required
  def display_board
    #temp func whilst testing
    # 6.times do |x|
    #   7.times do |y|
    #     print state[x,y]
    #   end
    #   puts
    # end
  end

  def move_valid?(move)
    state[move].any?(&:zero?)
  end 

  def make_move(x, player)
    y = state[x].index(0)
    raise 'InvalidMove' if y.nil?
    state[x][y] = player
    check_for_win(x, y)
  end

  def check_for_win(x, y)
    DIRECTIONAL_PAIRS.any? do |pair|
       count = 1
       pair.each do |direction|
          count += count_matches(x, y, direction)
       end
 
       if count >= 4
          return game.won == true
       end
    end
  end
 
  def count_matches(x, y, direction)
    return 0 unless next_matches?(x, y, direction)
    count_matches(new_coords(x, y, direction), direction) + 1
  end
    
  def next_matches?(x, y, direction)
    next_x, next_y = new_coords(x, y, direction)
 
    return false unless next_x.between?(0, 6)
    return false unless next_y.between?(0, 5)
 
    state[x][y] == state[next_x][next_y]
  end
    
  def new_coords(x, y, direction)
    nx = x + direction.first
    ny = y + direction.last
    [nx, ny]
  end
end

# frozen_string_literal: true

DIRECTIONAL_PAIRS = [[[0, 1][0, -1]], [[1, 1],
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
  #   directional_pairs.any do |pair|
  #     count = 1
  #     pair.each do |dir|
  #        count += count_matches(x, y, dir)
  #     end

  #     if count >= 4
  #        game.won == true
  #     end
  #  end
  end
end

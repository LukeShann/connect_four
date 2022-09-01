# frozen_string_literal: true

DIRECTIONAL_PAIRS = [[[0, 1][0, -1]], [[1, 1],
    [-1, -1]], [[1, 0], [-1, 0]], [[-1, 1], [1, -1]]]

class Board
  def initialize(game)
    @state = Array.new(7, Array.new(6))
    @game = game
  end
end

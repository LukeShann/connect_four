# frozen_string_literal: true

require_relative 'board'

class Game
  def initialize
    @board = Board.new
    @current_player = 1
  end
end

# frozen_string_literal: true

require_relative 'board'

class Game
  def initialize
    @board = Board.new
    @current_player = 1
  end

  def change_turn
    @current_player = @current_player == 1 ? 2 : 1
  end
end

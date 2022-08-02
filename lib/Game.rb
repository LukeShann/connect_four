require_relative 'Board'

class Game
  def initialize
    @board = Board.new
    @current_player = 1
  end
end
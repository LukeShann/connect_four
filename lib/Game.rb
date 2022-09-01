# frozen_string_literal: true

require_relative 'board'

class Game
  def initialize
    @board = Board.new
    @won = false
    @current_player = 1
  end

  def change_turn
    @current_player = @current_player == 1 ? 2 : 1
  end

  # Looping script method which will require testing
  def play
    # display instructions
    loop do
      take_turn
      break if won?
      change_turn
    end
  end

  # Looping script method which will require testing
  def take_turn
    # display board
    move = nil
    loop do
      move = get_input
      break if @board.move_valid?(move)
      # display invalid turn message
    end
    @board.make_move(move, @current_player)
  end
  
  def won?
    @won
  end

  def get_input
    # Prompt for input until valid
    input = nil
    loop do
      # prompt for input
      input = gets.chomp.to_i
      break if input_valid?(input)
    end
    input - 1
  end
  
  def input_valid?(i)
    (1..7).include?(i)
  end
end


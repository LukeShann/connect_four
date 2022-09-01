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
  def play_game
    # Call welcome message
    # Loop through turns
      # Display whose turn it is
      # get_input
      # Update board
      # Check board for winning state
        # return win_game if won
        # If not won change turn
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
  
  def win_game
    # Update board
    # Display victory message
    # Prompt for restart
  end
end


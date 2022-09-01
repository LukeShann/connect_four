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
end

def get_input
  # Prompt for input until valid
  input = ''
  until input_valid?(input)
    puts "#{@current_player == 1 ? 'Yellow' : 'Red'} Player's turn, pick a column"
    input = gets.to_i
  end
end

def input_valid?(input)
  # Check if input is an int 1 - 7
end

def win_game
  # Update board
  # Display victory message
  # Prompt for restart
end

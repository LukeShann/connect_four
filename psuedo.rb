-------------MAIN
game = Game.new
game.play

-------------GAME

class Game

def initialize
   board = Board.new(self)
   won = false
   player = 1
end

def play
   display instructions
   loop do
      take_turn
      break if won
      change_turns
   end
   declare winner message
end

def take_turn
    display board
    move = nil
    loop do
       move = get_input
       break if board.move_valid?(move)
       display invalid turn message
     end
     board.make_move(move, player)
end

def change_turns
   turns = turn == 1 ? 2 : 1
end

def get_input
   input = nil
   loop do
      prompt for input
      input = gets.chomp.to_i
      break if input_is_valid?(input)
   end
   input - 1
end

def input_valid?(i)
   (1..7).include?(i)
end

-------------BOARD
def intialize(game)
   state = Array.new(7, Array.new(6, nil)
   game = game
   directional_pairs = [ [[0, 1][0, -1]], [[1, 1],
      [-1, -1]], [[1, 0], [-1, 0]], [[-1, 1], [1, -1]] ]
end

def display_board
   (temp func whilst testing)
   7.times do x
      6.times do y
         print state[x,y]
end

def move_valid?(move)
   state[move].any(&:nil?)
end

def make_move(x, player)
   y = state[x].index(nil)
   state[x][y] = player
   check_for_win(x, y)
end

def check_for_win(x, y)
   directional_pairs.any do pair
      count = 1
      pair.each do dir
         count += count_matches(x, y, dir)
      end

      if count >= 4
         game.won == true
      end
   end
end

def count_matches(x, y, direction)
   return 0 unless next_matches?(x, y,    
      direction)
   return 0 unless x.between?(0..6)
   return 0 unless y.between?(0..6)
   count_matches(new_coords(x, y)) + 1
end

def next_matches?(x, y, direction)
   state[x, y] == state[new_coords(x,y)]
end

def new_coords(x, y, direction)
   nx = state[x + direction.first]
   ny = state[y + direction.last]
   nx, ny
end
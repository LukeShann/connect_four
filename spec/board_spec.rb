# frozen_string_literal: true

require_relative '../lib/board'
require_relative '../lib/game'

describe Board do
  let(:test_game) { Game.new }
  subject(:test_board) { Board.new(test_game) }
  
  describe '.initialize' do

    it 'assigns the game that created it to a variable' do
      board = test_game.instance_variable_get(:@board)
      game_on_board = board.instance_variable_get(:@game)
      expect(game_on_board).to be(test_game)
    end
    
    it 'has access to the directional pairs array' do
      expect(DIRECTIONAL_PAIRS.is_a?(Array)).to be(true)
    end

    context 'creates an two dimensional Array as the board state' do
      before do
        @state = test_board.instance_variable_get(:@state)
      end

      it 'initiates a state variable of type Array' do
        expect(@state).to be_an(Array)
      end

      it 'is of length 7' do
        expect(@state.length).to eq(7)
      end

      it 'is full of length 6 Arrays' do
        result = @state.all? { |i| i.is_a?(Array) && i.length == 6}
        expect(result).to be(true)
      end
    end
  end

  context 'when a game is in progress' do
    before do
      board_in_progress = [[1, 2, 2, 0, 0, 0],
                           [1, 2, 1, 1, 2, 2],                                                               
                           [2, 1, 2, 2, 1, 1],                                                               
                           [1, 2, 1, 2, 2, 0],                                                               
                           [1, 2, 1, 0, 0, 0],                                                               
                           [2, 1, 2, 1, 1, 0],                                                               
                           [0, 0, 0, 0, 0, 0]]
      test_board.state = board_in_progress
    end

    describe '.move_valid?' do
      it 'accepts a valid move' do
        result = test_board.move_valid?(4)
        expect(result).to be(true)
      end

      it 'rejects an invalid move' do
        result = test_board.move_valid?(1)
        expect(result).to be(false)
      end
    end

    describe '.make_move' do
      it 'correctly places in empty column' do
        expect { test_board.make_move(0, 1) }.to \
          change { test_board.state[0][3] }
          .from(0)
          .to(1)
      end

      it 'correctly places in half full column' do
        expect { test_board.make_move(0, 1) }.to \
          change { test_board.state[0][3] }
          .from(0)
          .to(1)
      end

      it 'throws an error in full column' do
        expect { test_board.make_move(1, 2) }.to raise_error('InvalidMove')
      end

      it 'checks for a winning combination from the relevent coords' do
        expect(test_board).to receive(:check_for_win).with(4, 3)
        test_board.make_move(4, 2)
      end
    end

  end
end

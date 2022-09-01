# frozen_string_literal: true

require_relative '../lib/board'
require_relative '../lib/game'

describe Board do
  let(:test_game) { Game.new }
  subject(:test_board) { Board.new(test_game) }

  describe '.initialize' do
    context 'creates an two dimensional Array as the boards state' do
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
    
    it 'assigns the game that created it to a variable' do
      board = test_game.instance_variable_get(:@board)
      game_on_board = board.instance_variable_get(:@game)
      expect(game_on_board).to be(test_game)
    end

    it 'has access to the directional pairs array' do
      expect(DIRECTIONAL_PAIRS.is_a?(Array)).to be(true)
    end
  
  end

end

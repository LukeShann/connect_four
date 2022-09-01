# frozen_string_literal: true

require_relative '../lib/game'

describe Game do
  subject(:created_game) { Game.new }

  describe '.initialize' do
    context 'when creating a new game' do
      it 'creates a new board object' do
        expect(Board).to receive(:new)
        described_class.new
      end
  
      it 'assigns board to an instance variable' do
        board = created_game.instance_variable_get(:@board)
        expect(board).to be_an_instance_of(Board)
      end
  
      it 'sets starting player to 1' do
        starting_player = created_game.instance_variable_get(:@current_player)
        expect(starting_player).to eq(1)
      end

      it 'sets won variable to false' do
        won = created_game.instance_variable_get(:@won)
        expect(won).to eq(false)
      end
    end
  end

  describe '.play' do
    before do
      allow(created_game).to receive(:take_turn)
      allow(created_game).to receive(:change_turn)
    end

    context 'when three turns are taken before winning' do
      before do
        allow(created_game).to receive(:won?).and_return(false, false, true)
      end

      it 'takes three turns' do
        expect(created_game).to receive(:take_turn).exactly(3).times
        created_game.play
      end
      
      it 'changes player twice' do
        expect(created_game).to receive(:change_turn).exactly(2).times
        created_game.play
      end
    end

    it 'does not change turn if game is won' do
      allow(created_game).to receive(:won?).and_return(true)
      expect(created_game).to receive(:take_turn).once
      created_game.play
    end
  end

  describe '.take_turn' do
    before do
      allow(created_game).to receive(:get_input)
      @board = double('board')
      created_game.instance_variable_set(:@board, @board)
      allow(@board).to receive(:make_move)
    end
    
    it 'asks for input again if move is not valid' do
      allow(@board).to receive(:move_valid?).and_return(false, true)
      expect(created_game).to receive(:get_input).twice
      created_game.take_turn
    end

    context 'when a move is valid' do
      it 'sends .make_move correctly' do
        allow(@board).to receive(:move_valid?).and_return(true)
        allow(created_game).to receive(:get_input).and_return(6)
        expect(@board).to receive(:make_move).with(6, 1)
        created_game.take_turn
      end
    end
  end

  describe '#change_turn' do
    it 'changes turn from 1 to 2' do
      expect { created_game.change_turn }.to \
        change { created_game.instance_variable_get(:@current_player) }
        .from(1)
        .to(2)
    end

    context "when it's player 2's turn" do
      before do
        created_game.instance_variable_set(:@current_player, 2)
      end

      it 'changes turn from 2 to 1' do
        expect { created_game.change_turn }.to \
          change { created_game.instance_variable_get(:@current_player) }
          .from(2)
          .to(1)
      end
    end
  end

  describe '.won?' do
    it 'returns true when @won is true' do
      created_game.instance_variable_set(:@won, true)
      expect(created_game.won?).to eq(true)
    end

    it 'returns false when @won is false' do
      created_game.instance_variable_set(:@won, false)
      expect(created_game.won?).to eq(false)
    end
  end

  describe '.get_input' do
    context 'when it is given wrong input' do
      it 'asks for input again' do
        allow(created_game).to receive(:input_valid?).and_return(false, true)
        allow(created_game).to receive(:gets).and_return('5')
        expect(created_game).to receive(:gets).twice
        created_game.get_input
      end
    end

    context 'when input is 4' do
      it 'returns index of 3' do
        allow(created_game).to receive(:input_valid?).and_return(true)
        allow(created_game).to receive(:gets).and_return('4\n')
        expect(created_game.get_input).to eq(3)
      end
    end
  end

  describe '#input_valid?' do
    it 'accepts valid input' do
      expect(created_game.input_valid?(5)).to eq(true)
    end
    
    it 'rejects 0' do
      expect(created_game.input_valid?(0)).to eq(false)
    end
    
    it 'rejects high numbers' do
      expect(created_game.input_valid?(10)).to eq(false)
    end

    it 'rejects negative numbers' do
      expect(created_game.input_valid?(-2)).to eq(false)
    end
  end
end

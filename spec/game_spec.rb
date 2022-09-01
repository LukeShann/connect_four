# frozen_string_literal: true

require_relative '../lib/game'

describe Game do
  subject(:created_game) { Game.new }

  describe '.initialize' do
    context 'Creating a new game' do
      it 'Creates a new board object' do
        expect(Board).to receive(:new)
        described_class.new
      end
  
      it 'Assigns board to an instance variable' do
        board = created_game.instance_variable_get(:@board)
        expect(board).to be_an_instance_of(Board)
      end
  
      it 'Sets starting player to 1' do
        starting_player = created_game.instance_variable_get(:@current_player)
        expect(starting_player).to eq(1)
      end

      it 'Sets won variable to false' do
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

    context 'three turns are taken before winning' do
      before do
        allow(created_game).to receive(:won?).and_return(false, false, true)
      end

      it 'continues to take turns' do
        expect(created_game).to receive(:take_turn).exactly(3).times
        created_game.play
      end
      
      it 'continues to change turns until won' do
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

  describe '#change_turn' do
    it 'Changes turn from 1 to 2' do
      expect { created_game.change_turn }.to \
        change { created_game.instance_variable_get(:@current_player) }
        .from(1)
        .to(2)
    end

    context "When it's player 2's turn" do
      before do
        created_game.instance_variable_set(:@current_player, 2)
      end

      it 'Changes turn from 2 to 1' do
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
    context 'it is given wrong input' do
      it 'asks for input again' do
        allow(created_game).to receive(:input_valid?).and_return(false, true)
        allow(created_game).to receive(:gets).and_return('5')
        expect(created_game).to receive(:gets).twice
        created_game.get_input
      end
    end

    context 'input is 4' do
      it 'returns index of 3' do
        allow(created_game).to receive(:input_valid?).and_return(true)
        allow(created_game).to receive(:gets).and_return('4\n')
        expect(created_game.get_input).to eq(3)
      end
    end
  end

  describe '.input_valid?' do
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

# frozen_string_literal: true

require_relative '../lib/game'

describe Game do
  subject(:created_game) { Game.new }

  context '.initialize' do
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

  context '.change_turn' do
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

  context '.get_input' do
    context 'it is given wrong input' do
      let(:receiver) { double(created_game) }

      it 'asks for input again' do
        created_game.stub(:get_input) { false }
        expect(created_game.to receive(:gets).twice)
        created_game.get_input
      end
    end
  end

  context '.input_valid?' do
  end

  context '.win_game' do
  end
end

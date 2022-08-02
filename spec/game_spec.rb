# frozen_string_literal: true

require_relative '../lib/game'

describe Game do
  subject(:created_game) { Game.new }

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
  end

  context 'Game methods' do
    context '#change_turn' do
      subject(:created_game) { Game.new }

      it 'Changes turn from 1 to 2' do
      end
    end
  end
end

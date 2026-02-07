# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/player'

describe Game do
  subject(:game) { described_class.new }

  describe '#player_choice' do
    context 'when the player makes a valid choice' do
      before do
        allow(game).to receive(:gets).and_return('3')
      end
      it 'does not display the error message' do
        error_message = 'Please choose one of the available choices on the board'
        expect(game).not_to receive(:puts).with(error_message)
        game.player_choice
      end

      it 'returns the choice' do
        return_value = game.player_choice
        expect(return_value).to eq('3')
      end
    end

    context 'when the player makes an invalid choice' do
      before do
        allow(game).to receive(:update_choices)
      end
      it 'does display the error message' do
        allow(game).to receive(:gets).and_return('e', '3')
        error_message = 'Please choose one of the available choices on the board'
        expect(game).to receive(:puts).with(error_message).once
        game.player_choice
      end
      it 'does display the error message multiple times' do
        allow(game).to receive(:gets).and_return('e', '12', '3')
        error_message = 'Please choose one of the available choices on the board'
        expect(game).to receive(:puts).with(error_message).twice
        game.player_choice
      end
    end
  end

  describe '#prepare_new_turn' do
    it 'increases the @turns variable' do
      game.set_up_game
      turns_before = game.instance_variable_get(:@turns)
      game.prepare_new_turn
      turns_after = game.instance_variable_get(:@turns)
      expect(turns_after).to eq(turns_before + 1)
    end
    it 'changes the player' do
      game.set_up_game
      player_before = game.instance_variable_get(:@current_player)
      game.prepare_new_turn
      player_after = game.instance_variable_get(:@current_player)
      expect(player_after).not_to eq(player_before)
    end

    it 'changes the player to player 2' do
      game.set_up_game
      game.prepare_new_turn
      player_after = game.instance_variable_get(:@current_player)
      expect(player_after.name).to eq('Player 2')
    end
  end

  describe '#update_choices' do
    let(:add_choice) { double(add_choice) }
    let(:player) { double }
    it 'places the players sign on the board' do
      game.set_up_game
      choice = '3'
      allow(player).to receive(:sign).and_return('&')
      allow(player).to receive(:add_choice)
      game.update_choices(choice, player)
      board_after = game.instance_variable_get(:@board)
      expect(board_after[choice.to_i - 1]).to eq('&')
    end
    it 'removes the chosen number from the @choices options' do
      game.set_up_game
      choice = '3'
      allow(player).to receive(:sign).and_return('&')
      allow(player).to receive(:add_choice)
      game.update_choices(choice, player)
      choices_after = game.instance_variable_get(:@choices)
      expect(choices_after.include?('3')).to be false
    end

    it 'calls the add_choices method of the player' do
      game.set_up_game
      choice = '3'
      allow(player).to receive(:sign).and_return('&')
      expect(player).to receive(:add_choice)
      game.update_choices(choice, player)
    end
  end

  describe '#player_won?' do
    let(:player) { double }
    it 'returns true, for a row' do
      allow(player).to receive(:choices).and_return(%w[4 5 6])
      result = game.player_won?(player)
      expect(result).to be true
    end
    it 'returns true, for a column' do
      allow(player).to receive(:choices).and_return(%w[1 4 7])
      result = game.player_won?(player)
      expect(result).to be true
    end
    it 'returns true, for a diagonal' do
      allow(player).to receive(:choices).and_return(%w[1 5 9])
      result = game.player_won?(player)
      expect(result).to be true
    end
    it 'returns false, for a not winning combination' do
      allow(player).to receive(:choices).and_return(%w[1 2 4 5])
      result = game.player_won?(player)
      expect(result).to be false
    end
  end

  describe '#game_over?' do
    it 'is true when turns equals max turns' do
      game.set_up_game
      game.instance_variable_set(:@turns, 9)
      result = game.game_over?
      expect(result).to be true
    end
    it 'is true when a winner ist declared' do
      game.set_up_game
      game.instance_variable_set(:@winner, 'Player 1')
      result = game.game_over?
      expect(result).to be true
    end
  end
end

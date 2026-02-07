# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/player'

describe Game do
  subject(:game) { described_class.new }

  describe '#player_choice' do
    context 'when the player makes a valid choice' do
      let(:update_choices) { double('update_choices') }

      before do
        allow(game).to receive(:gets).and_return('3')
      end
      it 'does not display the error message' do
        error_message = 'Please choose one of the available choices on the board'
        expect(game).not_to receive(:puts).with(error_message)
        game.player_choice
      end
    end
  end
end

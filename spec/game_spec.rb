# frozen_string_literal: true

require_relative '../lib/game'

# zu testen:
# Auswahl:
# - kann man freie felder auswählen?
# - kommt es zu einem fehler, wenn man etwas falsches wählt
# a: was es nicht gibt (buchstabe)
# b: ein besetztes feld
#
# hört das spiel auf, wenn jemand gewonnen hat?
# a vertikal
# b horizontal
# c diagonal
# hört das spiel auf, wenn es keine optionen mehr gibt (> 9 turns

describe Game do
  subject(:game) { described_class.new }
  describe '#check_result' do
    let(:winning_player) { double('player') }

    context 'when one player has three in a row' do
      xit 'displays the winner an'
    end
  end
end

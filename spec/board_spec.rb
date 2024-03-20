# frozen_string_literal: true

require_relative '../lib/player'
require_relative '../lib/board'

describe Board do
  describe '#add_players' do
    before do
      allow(Player).to receive(:ask_name).and_return('Ali', 'Aizad')
      allow(Player).to receive(:ask_symbol).and_return('O', 'X')
      allow(Player).to receive(:initialize)
    end

    it 'returns an array of length 2' do
      expect(described_class.add_players.length).to eql(2)
    end

    it 'returns an array of Player objects' do
      expect(described_class.add_players.all? { |obj| obj.is_a? Player }).to be true
    end
  end
end

# frozen_string_literal: true

require_relative '../lib/player'
require_relative '../lib/board'

describe Board do # rubocop:disable Metrics/BlockLength
  # setting mock player objects so that they dont have to be called each time
  let(:players) { [Player.new('Ali', 'O'), Player.new('Aizad', 'X')] }

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

  describe '#play' do
    describe '#display_array' do
      # test consists of print statements, omitted
    end

    describe '#ask_player_choice' do
      subject(:board_choice) { described_class.new(players) }
      context 'with inputs at unoccupied space' do
        before do
          player_list = board_choice.instance_variable_get(:@players)
          player_one = player_list[0]
          player_two = player_list[1]
          allow(player_one).to receive(:choose).and_return(1)
          allow(player_two).to receive(:choose).and_return(2)
        end

        it 'changes two cells in @array' do
          original = (1..9).to_a
          changes = ['O', 'X', 3, 4, 5, 6, 7, 8, 9]
          expect { board_choice.send(:ask_player_choice) }.to change { board_choice.array }.from(original).to(changes)
        end
      end

      context 'with inputs at occupied space' do
        it '#space_occupied? is true' do
          board_choice.array = ['X', 2, 3, 4, 5, 6, 7, 8, 9]
          player_choice = 1
          index = player_choice - 1
          result = board_choice.send :space_occupied?, index
          expect(result).to be true
        end
      end
    end
  end
end

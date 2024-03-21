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

  describe '#play' do # rubocop:disable Metrics/BlockLength
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
          board_choice.array[0] = 'X'
          player_choice = 1
          index = player_choice - 1
          result = board_choice.send :space_occupied?, index
          expect(result).to be true
        end
      end
    end

    describe '#game_over?' do # rubocop:disable Metrics/BlockLength
      describe '#winner?' do # rubocop:disable Metrics/BlockLength
        describe '#row_win?' do
          subject(:board_row_win) { described_class.new(players) }
          context 'checks if a row is filled with the same symbol' do
            it 'returns true if a row is filled with the same symbol' do
              board_row_win.array[0] = 'X'
              board_row_win.array[1] = 'X'
              board_row_win.array[2] = 'X'
              result = board_row_win.send(:row_win?)
              expect(result).to be true
            end

            it 'returns false if a row is not filled with the same symbol' do
              board_row_win.array[0] = 'X'
              board_row_win.array[1] = 'X'
              board_row_win.array[2] = 'O'
              result = board_row_win.send(:row_win?)
              expect(result).to be false
            end
          end
        end

        describe '#column_win?' do
          subject(:board_column_win) { described_class.new(players) }
          context 'checks if a column is filled with the same symbol' do
            it 'returns true if a column is filled with the same symbol' do
              board_column_win.array[0] = 'X'
              board_column_win.array[3] = 'X'
              board_column_win.array[6] = 'X'
              result = board_column_win.send(:column_win?)
              expect(result).to be true
            end

            it 'returns false if a column is not filled with the same symbol' do
              board_column_win.array[0] = 'X'
              board_column_win.array[3] = 'X'
              board_column_win.array[6] = 'O'
              result = board_column_win.send(:column_win?)
              expect(result).to be false
            end
          end
        end

        describe '#diagonal_win?' do # rubocop:disable Metrics/BlockLength
          subject(:board_diag_win) { described_class.new(players) }
          describe '#first_diag?' do
            context 'the first diagonal win condition is at index 0, 4, 8' do
              it 'returns true if diag is filled with the same symbol' do
                board_diag_win.array[0] = 'X'
                board_diag_win.array[4] = 'X'
                board_diag_win.array[8] = 'X'
                result = board_diag_win.send(:first_diag?)
                expect(result).to be true
              end

              it 'returns false if diag is not filled with the same symbol' do
                board_diag_win.array[0] = 'X'
                board_diag_win.array[4] = 'X'
                board_diag_win.array[8] = 'O'
                result = board_diag_win.send(:first_diag?)
                expect(result).to be false
              end
            end
          end
          describe '#second_diag?' do
            context 'the second diagonal win condition is at index 2, 4, 6' do
              it 'returns true if diag is filled with the same symbol' do
                board_diag_win.array[2] = 'X'
                board_diag_win.array[4] = 'X'
                board_diag_win.array[6] = 'X'
                result = board_diag_win.send(:second_diag?)
                expect(result).to be true
              end

              it 'returns false if diag is not filled with the same symbol' do
                board_diag_win.array[2] = 'X'
                board_diag_win.array[4] = 'X'
                board_diag_win.array[6] = 'O'
                result = board_diag_win.send(:second_diag?)
                expect(result).to be false
              end
            end
          end
        end
      end

      describe '#full?' do
        subject(:board_full) { described_class.new(players) }
        context 'it checks whether the board is full' do
          it 'returns false when the board is not full' do
            result = board_full.send(:full?)
            expect(result).to be false
          end

          it 'returns true when the board is full' do
            board_full.array = %w[X O X O X O X O X]
            result = board_full.send(:full?)
            expect(result).to be true
          end
        end
      end
    end
  end
end

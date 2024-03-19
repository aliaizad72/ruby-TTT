# frozen_string_literal: true

require_relative '../lib/player'

describe Player do # rubocop:disable Metrics/BlockLength
  describe '#ask_name' do
    # get methods are tested thouroughly, omitted
  end

  describe '#ask_symbol' do
    subject(:player_ask_sym) { described_class.new('Ali', 'X') }
    context 'if an input is of length 1' do
      before do
        allow(player_ask_sym).to receive(:gets).and_return('O')
      end

      it 'outputs the input prompt once' do
        expect(player_ask_sym).to receive(:print).with('Enter your preferred symbol: ').once
        player_ask_sym.ask_symbol
      end

      it 'returns the input' do
        return_val = player_ask_sym.ask_symbol
        expect(return_val).to eq('O')
      end
    end

    context 'if inputs are of multiple length' do
      before do
        allow(player_ask_sym).to receive(:gets).and_return('Or', 'O')
      end

      it 'outputs the input prompt twice, and the error prompt once' do
        expect(player_ask_sym).to receive(:print).with('Enter your preferred symbol: ').twice
        expect(player_ask_sym).to receive(:puts).with('Please enter one character only!. Enter again below!').once
        player_ask_sym.ask_symbol
      end
    end
  end
end

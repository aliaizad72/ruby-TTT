# frozen_string_literal: true

require_relative '../lib/player'

describe Player do # rubocop:disable Metrics/BlockLength
  describe '#ask_name' do
    # get methods are tested thouroughly, omitted
  end

  describe '#ask_symbol' do # rubocop:disable Metrics/BlockLength
    subject(:player_ask_sym) { described_class.new('Ali', 'X') }
    context 'if an input is of length 1' do
      before do
        valid_input = 'O'
        allow(player_ask_sym).to receive(:gets).and_return(valid_input)
      end

      it 'outputs the input prompt once' do
        input_prompt = 'Enter your preferred symbol: '
        expect(player_ask_sym).to receive(:print).with(input_prompt).once
        player_ask_sym.ask_symbol
      end

      it 'returns the input' do
        return_val = player_ask_sym.ask_symbol
        expect(return_val).to eq('O')
      end
    end

    context 'if inputs are of multiple length' do
      before do
        invalid_input = 'OR'
        valid_input = 'O'
        allow(player_ask_sym).to receive(:gets).and_return(invalid_input, valid_input)
      end

      it 'outputs the input prompt twice, and the error prompt once' do
        input_prompt = 'Enter your preferred symbol: '
        error_prompt = 'Please enter one character only!. Enter again below!'
        expect(player_ask_sym).to receive(:print).with(input_prompt).twice
        expect(player_ask_sym).to receive(:puts).with(error_prompt).once
        player_ask_sym.ask_symbol
      end
    end
  end
end

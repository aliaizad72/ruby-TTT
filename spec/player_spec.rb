# frozen_string_literal: true

require_relative '../lib/player'

describe Player do # rubocop:disable Metrics/BlockLength
  describe '.ask_name' do
    # get methods are tested thouroughly, omitted
  end

  describe '.ask_symbol' do # rubocop:disable Metrics/BlockLength
    context 'if an input is of length 1' do
      before do
        valid_input = 'O'
        allow(described_class).to receive(:gets).and_return(valid_input)
      end

      it 'outputs the input prompt once' do
        input_prompt = 'Enter your preferred symbol: '
        expect(described_class).to receive(:print).with(input_prompt).once
        described_class.ask_symbol
      end

      it 'returns the input' do
        expect(described_class.ask_symbol).to eq('O')
      end
    end

    context 'if inputs are of multiple length' do
      before do
        invalid_input = 'OR'
        valid_input = 'O'
        allow(described_class).to receive(:gets).and_return(invalid_input, valid_input)
      end

      it 'outputs the input prompt twice, and the error prompt once' do
        input_prompt = 'Enter your preferred symbol: '
        error_prompt = 'Please enter one character only!. Enter again below!'
        expect(described_class).to receive(:print).with(input_prompt).twice
        expect(described_class).to receive(:puts).with(error_prompt).once
        described_class.ask_symbol
      end
    end
  end

  describe '#choose' do
    subject(:player_choose) { described_class.new('Aku', 'X') }

    context 'with valid input' do
      before do
        allow(player_choose).to receive(:gets).and_return('5')
      end

      it 'outputs the input prompt once' do
        name = player_choose.instance_variable_get(:@name)
        input_prompt = "#{name}, enter your choice on the board (1 to 9): "
        expect(player_choose).to receive(:print).with(input_prompt).once
        player_choose.choose
      end
    end

    context 'with one invalid input' do
      before do
        allow(player_choose).to receive(:gets).and_return('-1', '5')
      end

      it 'outputs the input prompt twice' do
        name = player_choose.instance_variable_get(:@name)
        input_prompt = "#{name}, enter your choice on the board (1 to 9): "
        error_prompt = 'Please enter a number from 1 to 9! Enter again below!'
        expect(player_choose).to receive(:print).with(input_prompt).twice
        expect(player_choose).to receive(:puts).with(error_prompt).once
        player_choose.choose
      end
    end
  end
end

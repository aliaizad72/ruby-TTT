# frozen_string_literal: true

# class Player to manage the relevant data of each players in the game
class Player
  attr_reader :name, :symbol

  # make it easier to test with mock params
  def initialize(name = ask_name, symbol = ask_symbol)
    @name = name
    @symbol = symbol
  end

  # Getting names from the players
  def ask_name
    print 'enter your name: '
    gets.chomp
  end

  # Getting symbols from the players
  def ask_symbol
    symbol = 'Placeholder == false' # This is a dummy value to make the loop below run
    # Error handling
    until symbol.length == 1
      print 'Enter your preferred symbol: '
      symbol = gets.chomp
      puts 'Please enter one character only!. Enter again below!' if symbol.length > 1
    end
    symbol
  end

  def choose # rubocop:disable Metrics/MethodLength
    player_choice = 'Placeholder == false'.to_i # This is a dummy value to make the loop below run
    # Error handling
    until choose_condition(player_choice)
      print "#{name}, enter your choice on the board (1 to 9): "
      player_choice = gets.chomp.to_i
      print 'Please enter a number from 1 to 9! Enter again below!' if choose_condition(player_choice) == false
    end
    player_choice
  end

  def choose_condition(player_choice)
    player_choice.positive? && player_choice < 10
  end
end

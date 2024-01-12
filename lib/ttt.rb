# frozen_string_literal: true

# class Player to manage the relevant data of each players in the game
class Player
  attr_reader :name, :symbol

  def initialize
    @name = ask_name
    @symbol = ask_symbol
  end

  # Getting names from the players
  def ask_name
    print 'enter your name: '
    gets.chomp
  end

  # Getting symbols from the players
  def ask_symbol # rubocop:disable Metrics/MethodLength
    symbol = 'Placeholder == false' # This is a dummy value to make the loop below run
    i = 0
    # Error handling
    while symbol.length > 1
      if i.zero?
        print 'Enter your preferred symbol: '
      else
        print 'Please enter one character only!. Enter again: '
      end
      symbol = gets.chomp
      i += 1
    end
    symbol
  end

  def choice # rubocop:disable Metrics/MethodLength
    player_choice = 'Placeholder == false'.to_i # This is a dummy value to make the loop below run
    i = 0
    # Error handling
    until player_choice.positive? && player_choice < 10
      if i.zero?
        print "#{name}, enter your choice on the board (1 to 9): "
      else
        print 'Please enter a number from 1 to 9! Enter again: '
      end
      player_choice = gets.chomp.to_i
      i += 1
    end
    player_choice
  end
end

# class Board to handle the operations and data needed to play the game
class Board
  attr_accessor :players, :array, :winner

  def initialize
    @players = add_players
    @array = (1..9).to_a # A place to store the current ongoing game
    @players_symbols = players.map(&:symbol)
    @winner = nil
  end

  def add_players
    players = []
    2.times do |i|
      print "Player #{i + 1}, "
      players.push(Player.new)
    end
    players.shuffle # Shuffle to randomise their turn
  end

  def play
    display_array
    ask_player_choice until game_over?

    if winner?
      announce_winner
    elsif full? && !winner?
      announce_draw
    end
  end

  # Method to output the current game to the user
  def display_array
    print "\n" # To make it easier on the eye
    array.each_index do |index|
      print " #{array[index]} "
      print "\n" if [2, 5, 8].include?(index)
    end
    print "\n"
  end

  def ask_player_choice # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    players.each do |player|
      index = player.choice - 1
      # To make sure player play an index that has not been taken
      while @players_symbols.include?(array[index])
        puts 'This position is occupied. Try another position.'
        print "\n"
        index = player.choice - 1
      end
      array[index] = player.symbol
      display_array
      @winner = player.name if winner?
      break if game_over?
    end
  end

  def game_over?
    winner? || full?
  end

  def winner?
    row_win? || column_win? || diagonal_win?
  end

  def row_win?
    result = false
    row_win_first_index = [0, 3, 6]
    row_win_first_index.each do |index|
      return true if array[index] == array[index + 1] && array[index] == array[index + 2]
    end
    result
  end

  def column_win?
    result = false
    column_win_first_index = [0, 1, 2]
    column_win_first_index.each do |index|
      return true if array[index] == array[index + 3] && array[index] == array[index + 6]
    end
    result
  end

  def diagonal_win?
    result = false
    return true if first_diag_win_condition || second_diag_win_condition

    result
  end

  def first_diag_win_condition
    array[4] == array[0] && array[4] == array[8]
  end

  def second_diag_win_condition
    array[4] == array[2] && array[4] == array[6]
  end

  def full?
    array.all? { |position| @players_symbols.include?(position) }
  end

  def announce_winner
    puts "#{winner}, you won the game!"
  end

  def announce_draw
    puts 'Nobody wins, game ends in a draw.'
  end
end

# class Game to manage the flow of the game
class Game
  # The whole game flow is here
  def play
    intro
    current_board = Board.new
    current_board.play
  end

  # Introduce the game and the rules
  def intro
    puts 'Welcome to Tic-Tac-Toe! Who goes first are randomised.'
  end
end

Game.new.play

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
  def ask_symbol
    print 'Enter your preferred symbol: '
    gets.chomp
  end

  def choice
    print "#{name}, enter your choice on the board (1 to 9): "
    gets.chomp.to_i
  end

  def announce_winner
    puts "#{name}, you won the game!"
  end
end

# class Board to handle the operations and data needed to play the game
class Board
  attr_accessor :players, :array

  def initialize
    @players = add_players
    @array = (1..9).to_a # A place to store the current ongoing game
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
    display
    take_choice until game_over?
    announce_draw if draw?
  end

  # Method to output the current game to the user
  def display
    array.each_index do |index|
      print " #{array[index]} "
      print "\n" if [2, 5, 8].include?(index)
    end
  end

  def take_choice
    players.each do |player|
      next if game_over?

      index = player.choice - 1
      array[index] = player.symbol
      display
      player.announce_winner if winner?
    end
  end

  def game_over?
    winner? || draw?
  end

  # to check if there is a winner
  def winner?
    row_win? || column_win? || diagonal_win?
  end

  # Tested
  def row_win?
    result = false
    row_win_first_index = [0, 3, 6]
    row_win_first_index.each do |index|
      return true if array[index] == array[index + 1] && array[index] == array[index + 2]
    end
    result
  end

  # Tested
  def column_win?
    result = false
    column_win_first_index = [0, 1, 2]
    column_win_first_index.each do |index|
      return true if array[index] == array[index + 3] && array[index] == array[index + 6]
    end
    result
  end

  # Tested
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

  def draw?
    players_symbols = players.map(&:symbol)
    array.all? { |position| players_symbols.include?(position) }
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
    puts 'Welcome to Tic-Tac-Toe!'
  end
end

Game.new.play

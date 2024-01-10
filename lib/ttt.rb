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
end

# class Board to handle the operations and data needed to play the game
class Board
  attr_accessor :players, :state

  def initialize
    @players = add_players
    @state = (1..9).to_a # A place to store the current ongoing game
  end

  def add_players
    players = []
    2.times do |i|
      print "Player #{i + 1}, "
      players.push(Player.new)
    end
    players
  end

  # Method to output the current game to the user
  def display
    state.each do |pos|
      print " #{pos} "
      print "\n" if (pos % 3).zero?
    end
  end

  def play
    display
  end

  def winner?
    row_win? || column_win? || diagonal_win?
  end

  def row_win?
    result = false
    row_win_first_index = [0, 3, 6]
    row_win_first_index.each do |index|
      return true if state[index] == state[index + 1] && state[index] == state[index + 2]
    end
    result
  end

  def column_win?
    result = false
    column_win_first_index = [0, 1, 2]
    column_win_first_index.each do |index|
      return true if state[index] == state[index + 3] && state[index] && state[index + 6]
    end
    result
  end

  def diagonal_win?
    result = false
    return true if first_diag_win_condition || second_diag_win_condition

    result
  end

  def first_diag_win_condition
    state[4] == state[0] && state[4] == state[8]
  end

  def second_diag_win_condition
    state[4] == state[2] && state[4] == state[6]
  end
end

# class Game to manage the flow of the game
class Game
  # The whole game flow is here
  def play
    intro
    Board.new.play
  end

  # Introduce the game and the rules
  def intro
    puts 'Welcome to Tic-Tac-Toe!'
  end
end

# frozen_string_literal: true

# class Board to handle the operations and data needed to play the game
class Board
  attr_accessor :players, :array, :winner

  def initialize
    @players = add_players
    @array = (1..9).to_a # A place to store the current ongoing game
    @players_symbols = players.map(&:symbol)
    @winner = nil
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

  def reset
    @players = @players.shuffle # Randomising the turns for the new game
    @array = (1..9).to_a
    @winner = nil
  end

  private

  def add_players
    players = []
    2.times do |i|
      name = Player.ask_name(i)
      symbol = Player.ask_symbol
      player = Player.new(name, symbol)
      players.push(player)
    end
    players.shuffle # Shuffle to randomise their turn
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
      index = player.choose - 1
      # To make sure player play an index that has not been taken
      while @players_symbols.include?(array[index])
        puts 'This position is occupied. Try another position.'
        print "\n"
        index = player.choose - 1
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

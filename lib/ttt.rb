# frozen_string_literal: true

# class Player to manage the relevant data of each players in the game
class Player
  attr_reader :name, :symbol

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end
end

# class IO to manage the flow of the game, I0 = input/output
class IO
  # Introduce the game and the rules
  def intro
    puts 'Welcome to Tic-Tac-Toe!'
  end

  # Getting names from the players
  def ask_name(player_num)
    print "Player #{player_num}, enter your name: "
    gets.chomp
  end
end
# Randomising symbol for each player
symbols = %w[X O]
player_1_symbol = symbols.delete(symbols.sample)
player_2_symbol = symbols[0]
# Randomising the turn of each player
turn = [0, 1]
player_1_turn = turn.delete(turn.sample)
player_2_turn = turn[0]
# Output the information to the players
puts "#{player_1_name}, your symbol is #{player_1_symbol}."
puts "#{player_2_name}, your symbol is #{player_2_symbol}."
# A place to store the current ongoing game
current_game = (1..9).to_a
# Method to output the current game to the user
def display(array)
  array.each do |pos|
    print " #{pos} "
    print "\n" if (pos % 3).zero?
  end
end
display current_game
# Play the game
# Check which player's turn is it

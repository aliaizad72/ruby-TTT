# frozen_string_literal: true

# Introduce the game and the rules
puts 'Welcome to Tic-Tac-Toe!'
# Getting names from the players
print 'Player 1, enter your name: '
player_1_name = gets.chomp
print 'Player 2, enter your name: '
player_2_name = gets.chomp
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
# Conditions that will end the game
# 1. Row complete
# 2. Column complete
# 3. Diagonal complete

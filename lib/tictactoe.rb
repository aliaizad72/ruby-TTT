# frozen_string_literal: true

# class TicTacToe to manage the flow of the game
class TicTacToe
  # The whole game flow is here
  def self.play
    puts 'Welcome to Tic-Tac-Toe! Who goes first are randomised.'
    board = Board.new
    board.play
    while play_again?
      board.reset
      board.play
    end
    puts 'Goodbye!'
  end

  def self.play_again?
    print 'Do you want to play again? (y/n): '
    gets.chomp == 'y'
  end
end

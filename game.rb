require './board.rb'
require './tile.rb'

class Game

  attr_accessor :board

  def initialize(num_bombs, board_size)
    @board = Board.new(num_bombs, board_size)
  end

  def play
    until board.win? || board.lose?
      board.display

      puts "Choose a row (0-8):"
      row = gets.chomp.to_i
      puts "Choose a column (0-8):"
      col = gets.chomp.to_i

      puts "Choose an action: F for flag, R for reveal:"
      action = gets.chomp.downcase

      tile = board[[row, col]]
      action == "f" ? tile.flag : tile.reveal
    end

    message = board.win? ? "congrats!" : "sorry!"
    puts message
  end

end

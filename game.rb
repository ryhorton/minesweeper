require './board.rb'
require './tile.rb'

class Game

  attr_accessor :board

  def initialize(num_bombs, board_size)
  end

  def play
    puts "Pick a board dimension (integer):"
    size = gets.chomp.to_i

    @board = Board.new(num_bombs(size), size)

    until board.win? || board.lose?
      board.display
      process_move(get_move)
    end

    message = board.win? ? "congrats!" : "sorry!"
    puts message
  end

  def num_bombs(size)
    size / 3
  end

  def get_move
    puts "Choose a row:"
    row = gets.chomp.to_i
    puts "Choose a column:"
    col = gets.chomp.to_i

    puts "Choose an action: F for flag, R for reveal:"
    action = gets.chomp.downcase

    [row, col, action]
  end

  def process_move(move)
    row, col, action = move

    tile = board[[row, col]]
    action == "f" ? tile.flag : tile.reveal

  end

end

require './tile.rb'

class Board

  attr_accessor :board, :bombs

  def initialize(num_bombs)
    @board = Array.new(9) { Array.new(9) }

    @bombs = bomb_positions(num_bombs)

    board.each_with_index do |row, i|
      row.each_index do |j|
        position = [i, j]
        bomb = bombs.include?(position)
        @board[i][j] = Tile.new(self, bomb, position) # board, boolean, array
      end
    end
  end

  def [](pos)
    x, y = pos
    board[x][y] # returns the relevant tile
  end

  def bomb_positions(num_bombs)
    positions = []

    until positions.size == num_bombs
      bomb_tile = [rand(8), rand(8)]
      positions << bomb_tile unless positions.include?(bomb_tile)
    end

    positions
  end

  def display
    puts render
  end

  def render
    board_string = ""
    @board.each_with_index do |row, i|
      board_string += "\n"
      row.each_index do |j|
        # calling Tile#render bc board[i][j] is a tile
        board_string += board[i][j].render + " "
      end
    end
    board_string
  end

  def win?
    all_bombs_flagged? && all_tiles_revealed?
  end

  def all_bombs_flagged?
    bombs.all { |(i, j)| board[i][j].status == :flagged }
  end

  def all_tiles_revealed?
    board.each do |tile|
      next if tile.is_bomb? # skip if the tile is a bomb
      if tile.status != :revealed
        return false
      end
    end

    true
  end

  def lose?
    # the tile the user inputs is a bomb
    board.any?{|tile| tile.status == :bombed}
  end

end

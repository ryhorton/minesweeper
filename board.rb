require './tile.rb'

class Board

  attr_accessor :board, :bombs

  def initialize(num_bombs, size)
    @board = Array.new(size) { Array.new(size) }

    bombs = seed(num_bombs)

    board.each_with_index do |row, i|
      row.each_index do |j|
        position = [i, j]
        bomb = bombs.include?(position)
        self[[i,j]] = Tile.new(self, bomb, position) # board, boolean, array
      end
    end
  end

  def []=(position, value)
    x,y = position
    board[x][y] = value
  end

  def [](pos)
    x, y = pos
    board[x][y] # returns the relevant tile
  end

  def bombs
    bombs = []
    board.flatten.each do |tile|
      bombs << tile if tile.is_bomb?
    end
    bombs
  end

  def seed(num_bombs)
    positions = []

    until positions.size == num_bombs
      bomb_tile = [rand(size), rand(size)]
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
    bombs.all? { |tile| self[tile.position].flagged? }
  end

  def all_tiles_revealed?
    board.flatten.each do |tile|
      next if tile.is_bomb? # skip if the tile is a bomb
      if tile.status != :revealed
        return false
      end
    end

    true
  end

  def lose?
    board.flatten.any?(&:bombed?) || false
  end

end

class Tile

  attr_reader :status, :is_bomb, :bombed, :revealed, :flagged, :position

  def initialize(board, bomb)
    @is_bomb = bomb
  end

  # def inspect
  #   "Position: #{position}, Status: #{status}"
  # end

  def status
    if bombed
      status = :b
    elsif revealed
      status = :r
    elsif flagged
      status = :f
    else
      status = :u # untouched
    end
  end

  def reveal
  end

  def neighbors
  end

  def neighbor_bomb_count
    # return int number of bombs in nieghboring tiles
  end

  def render

    displays = {
      :b => "B",
      :f => "F",
      :u => "*",
      :r => neighbor_bomb_count == 0 ? "_" : neighbor_bomb_count.to_s
    }

    displays[status]
  end

end

class Board

  attr_accessor :board, :bombs

  def initialize(num_bombs)
    @board = Array.new(9) { Array.new(9) }

    @bombs = bomb_positions(num_bombs)

    board.each_with_index do |row, i|
      row.each_index do |j|
        bomb = bombs.include?([i, j])
        @board[i][j] = Tile.new(self, bomb)
      end
    end
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
    # return every bomb is flagged and all other spaces are revealed

    # every bomb is flagged
    all_bombs_flagged = bombs.all { |(i, j)| board[i][j].status == :f }

    # all other spaces are revealed
    all_tiles_revealed = true

    board.each do |tile|

      next if tile.is_bomb # skip if the tile is a bomb
      if tile.status != :r
        all_tiles_revealed = false
      end

    end

    all_bombs_flagged && all_tiles_revealed
  end

  def lose?

  end

end


class Game

  # initialize board with num_bombs
  num_bombs = rand(10..20)

  until board.win? || board.lose?

  end

end



class HumanPlayer

end

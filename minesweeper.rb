class Tile

  attr_reader :status, :bomb, :bombed, :revealed, :flagged, :position

  def initialize(board, bomb)
    @bomb = bomb
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

  attr_accessor :board

  def initialize(num_bombs)
    @board = Array.new(9) { Array.new(9) }
    
    bombs = bomb_positions(num_bombs)

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

end


class Game

  num_bombs = rand(10..20)

  # initialize board with num_bombs

end



class HumanPlayer

end

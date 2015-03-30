class Tile

  attr_reader :status, :bombed?, :revealed?, :flagged?, :position

  def initialize(board)
  end

  def inspect
    "Position: #{position}, Status: #{status}"
  end

  def status
    if bombed?
      status = "Bombed"
    elsif revealed?
      status = "Revealed, number neighbor bombs: #{neighbor_bomb_count}"
    else
      status = "Flagged"
    end
  end

  def reveal
  end

  def neighbors
  end

  def neighbor_bomb_count
  end

end

class Board

  @board = Array.new(9) {Array.new(9)}

  def initialize(num_bombs)
    @board.each_with_index do |row,i|
      row.each_index do |j|

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

  end

end


class Game

  num_bombs = rand(10,20)

  # initialize board with num_bombs

end



class HumanPlayer

end

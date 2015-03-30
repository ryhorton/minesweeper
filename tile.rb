require './board.rb'

class Tile

  attr_reader :board, :status, :is_bomb, :bombed, :revealed, :flagged, :position

  def initialize(board, is_bomb, position)
    @is_bomb = is_bomb
    @position = position
    @board = board
  end

  # def inspect
  #   "Position: #{position}, Status: #{status}"
  # end

  def is_bomb?
    is_bomb
  end

  def inspect
    position.inspect
  end
  #
  # def status
  #   if bombed
  #     status = :bombed
  #   elsif revealed
  #     status = :revealed
  #   elsif flagged
  #     status = :flagged
  #   else
  #     status = :untouched # untouched
  #   end
  # end

  def reveal
    if is_bomb?
      status = :bombed
      return
    else
      # BFS
      status = :revealed

      q = [self]

      neighbors.each do |neighbor|

      end

    end
  end

  def valid_coord(x, y)
    x.between?(0, 8) && y.between?(0, 8)
  end

  def neighbors
    neighbor_diffs = [
      [-1,0],
      [-1,1],
      [0,1],
      [1,1],
      [1,0],
      [1,-1],
      [0,-1],
      [-1,-1]
    ]

    neighbors = []
    neighbor_diffs.each do |dx, dy|
      neighbor = [position.first + dx, position.last + dy]
      neighbors << neighbor if valid_coord(neighbor.first, neighbor.last)
    end

    neighbors.map {|i,j| board.tile(i, j)}
  end

  def neighbor_bomb_count
    count = 0
    neighbors.each do |x,y|
      ## HOW TO ADD [][] to BOARD???
      count += 1 if board.tile(x, y).is_bomb?
    end
    count
  end

  def render

    displays = {
      :bombed => "B",
      :flagged => "F",
      :untouched => "*",
      :revealed => neighbor_bomb_count == 0 ? "_" : neighbor_bomb_count.to_s
    }

    displays[status]
  end


end

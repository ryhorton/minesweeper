require './board.rb'

class Tile
  attr_accessor :status, :board, :is_bomb, :position

  NEIGHBOR_DIFFS = [
    [-1,0],
    [-1,1],
    [0,1],
    [1,1],
    [1,0],
    [1,-1],
    [0,-1],
    [-1,-1]
  ]


  def initialize(board, is_bomb, position)
    @is_bomb = is_bomb
    @position = position
    @board = board
    @status = :untouched
  end

  def is_bomb?
    is_bomb
  end

  def inspect
    position.inspect
  end

  def flag
    self.status = :flagged
  end

  def reveal
    return self.status = :bombed if is_bomb?

    self.status = :revealed

    queue = [self]
    until queue.empty?
      queue.shift.neighbors.each do |neighbor|
        next if neighbor.is_bomb?
        neighbor.status = :revealed

        if neighbor.neighbor_bomb_count == 0
          queue += neighbor.neighbors.select(&:untouched?)
        end

      end
    end
  end

  def untouched?
    status == :untouched
  end

  def bombed?
    status == :bombed
  end

  def flagged?
    status == :flagged
  end

  def valid_coord(pos)
    x, y = pos
    x.between?(0, 8) && y.between?(0, 8)
  end

  def neighbors
    return @neighbors if @neighbors

    neighbors = []
    NEIGHBOR_DIFFS.each do |dx, dy|
      neighbor_pos = [position.first + dx, position.last + dy]
      neighbors << neighbor_pos if valid_coord(neighbor_pos)
    end

    @neighbors = neighbors.map { |pos| board[pos] }
  end

  def neighbor_bomb_count
    count = 0
    neighbors.each do |tile|
      count += 1 if tile.is_bomb?
    end

    count
  end

  def render

    displays = {
      :bombed => "B",
      :flagged => "F",
      :untouched => "*",
      :revealed => (neighbor_bomb_count == 0) ? "_" : neighbor_bomb_count.to_s
    }

    displays[status]
  end


end

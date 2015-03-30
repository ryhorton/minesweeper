class Tile

  attr_reader :status, :bombed?, :revealed?, :flagged?, :position

  def initialize(board)

  end

  def inspect
    "Bombed: #{:bombed}"
  end

  def reveal
  end

  def neighbors
  end

  def neighbor_bomb_count
  end

end

class Board


end


class Game

end



class HumanPlayer

end

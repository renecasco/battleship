require './lib/board'

class Player
    attr_reader :name,
                :board

  def initialize(name, board)
    @name = name
    @board = board
  end
end

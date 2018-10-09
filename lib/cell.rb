require './lib/ship'

class Cell
  attr_reader :name,
              :contents,
              :peg

  def initialize(name)
    @name = name
    @contents = nil
    @peg = nil
  end

  def place_peg(peg)
    @peg = peg
  end

  def point_to_ship(ship)
    @contents = ship
  end
end

require './lib/ship'

class Cell
  attr_reader :name,
              :ship,
              :peg

  def initialize(name)
    @name = name
    @ship = nil
    @peg = " "
  end

  def place_peg
    if @ship == nil
      @peg = "W"
    else
      @peg = "R"
    end
  end

  def add_ship(ship)
    @ship = ship
  end
end

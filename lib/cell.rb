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

  def grid_y #returns grid y coord of any cell
    ("A".."J").to_a.index(@name[0])
  end
  def grid_x #returns grid x coord of any cell
    @name[1..-1].to_i - 1
  end
end

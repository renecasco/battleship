
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
    return :duplicate_shot_error if @peg != " "
    if @ship == nil
      @peg = "*"
    else
      @peg = "X"
    end
  end

  def add_ship(ship)
    @ship = ship
  end
end

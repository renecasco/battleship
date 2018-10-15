
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

# We have the following methods duplicated in Board. Do we need to keep both?
  def grid_y #returns grid y coord of any cell
    ("A".."J").to_a.index(@name[0])
  end

  def grid_x #returns grid x coord of any cell
    @name[1..-1].to_i - 1 #how about cell_name[1] since we're not looking through a range? We're just calling the second element in a string.
  end
end

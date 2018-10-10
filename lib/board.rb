require './lib/cell'

class Board
  attr_reader :cell_grid

  def initialize
    @cell_grid = generate_grid
  end

  def generate_grid
    ("A".."J").map do |y|
      (1..10).map { |x| Cell.new(y + x.to_s) }
    end
  end

  def print_board
    grid_string = "========================\n"
    grid_string += ". 1 2 3 4 5 6 7 8 9 10\n"
    y = 0
    while y <= 9 do
      grid_string += get_row(y)

      y += 1
    end
    grid_string += "========================"
  end

  def get_row(y)
    #Place letter at front of row string
    row_string = ("A".."J").to_a[y]
    #Place visual cell graphics in row string
    @cell_grid[y].each do |cell|
      row_string += cell.cell_graphic
    end
    row_string += "\n"
    row_string

  def cell_graphic(cell)
    if cell.peg == :hit
      " R"
    elsif cell.peg == :miss
      " W"
    else
      "  "
    end
  end

end

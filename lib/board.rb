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
    letter_key = ("A".."J").to_a
    row_string = letter_key[y]
    @cell_grid[y].each do |cell|
      if cell.peg == :hit
        row_string += " R"
      elsif cell.peg == :miss
        row_string += " W"
      else
        row_string += "  "
      end
    end
    row_string += "\n"
    row_string
  end

end

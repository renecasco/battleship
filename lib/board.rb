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
    print get_board_string
  end

  def get_board_string
    board_string = border
    board_string += header_row
    y = 0
    while y <= 9 do
      board_string += board_row(y)
      y += 1
    end
    board_string += border
  end

  def border
    "=======================\n"
  end

  def header_row
    ". 1 2 3 4 5 6 7 8 9 10\n"
  end

  def board_row(y)
    row_string = ("A".."J").to_a[y] #Place letter at front of row string
    @cell_grid[y].each do |cell| #Place visual cell graphics in row string
      row_string += " " + cell.peg
    end
    row_string += "\n"
  end

end

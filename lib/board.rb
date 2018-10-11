require './lib/cell'
require './lib/ship'

class Board
  attr_reader :cell_grid, :ship_array

  def initialize
    @cell_grid = generate_grid
    @ship_array = initialize_ships
  end

  def initialize_ships
    ship_specs = [ {name: "Destroyer", size: 2},
                  {name: "Submarine", size: 3},
                  {name: "Cruiser", size: 3},
                  {name: "Battleship", size: 4},
                  {name: "Carrier", size: 5} ]
    ship_specs.map { |spec| Ship.new(spec[:name], spec[:size]) }
  end

  def place_ship(ship, prow, stern)
    points = [{y: y_coord(prow),  x: x_coord(prow)},
              {y: y_coord(stern), x: x_coord(stern)}]
    error = placement_error_check(ship, points)
    return error if error != nil
    record_ship_in_cells(ship, points)
  end

  def record_ship_in_cells(ship, points)
    index = get_start_index(points)
    span(points).times do
      if direction(points) == :horizontal
        @cell_grid[points[0][:y]][index].add_ship(ship)
      else #if vertical
        @cell_grid[index][points[0][:x]].add_ship(ship)
      end
      index += 1
    end
  end

  def placement_error_check(ship, points)
    return :orientation_error if direction(points) == :diagonal
    return :length_error if span(points) != ship.size
    return :overlap_error if overlap_with_existing?(points)
    nil
  end


  def direction(points)
    if points[0][:y] == points[1][:y]
      :horizontal
    elsif points[0][:x] == points[1][:x]
      :vertical
    else
      :diagonal
    end
  end

  def span(points)
    if direction(points) == :horizontal
      (points[1][:x] - points[0][:x]).abs + 1
    else
      (points[1][:y] - points[0][:y]).abs + 1
    end
  end

  def overlap_with_existing?(points)
    index = get_start_index(points)
    overlapping?(points, index)
  end

  def get_start_index(points)
    if direction(points) == :horizontal
      points[1][:x] > points[0][:x] ? points[0][:x] : points[1][:x]
    else
      points[1][:y] > points[0][:y] ? points[0][:y] : points[1][:y]
    end
  end

  def overlapping?(points, index)
    overlap = false
    span(points).times do
      if direction(points) == :horizontal
        overlap = true if @cell_grid[points[0][:y]][index].ship
      else #if vertical
        overlap = true if @cell_grid[index][points[0][:x]].ship
      end
      index += 1
    end
    overlap
  end

  def y_coord(cell_name)
    ("A".."J").to_a.index(cell_name[0])
  end
  def x_coord(cell_name)
    cell_name[1..-1].to_i - 1
  end

  def generate_grid
    ("A".."J").map do |y|
      (1..10).map { |x| Cell.new(y + x.to_s) }
    end
  end

  def print_board(style = :complete)
    print get_board_string(style)
  end

  def get_board_string(style)
    board_string = border
    board_string += header_row
    y = 0
    while y <= 9 do
      board_string += board_row(y, style)
      y += 1
    end
    board_string += border
    if style == :contents
      board_string += board_key
    end
  end

  def border
    "=======================\n"
  end

  def board_key
    'Ship = S, Hit = X, Miss = *\n'
  end

  def header_row
    ". 1 2 3 4 5 6 7 8 9 10\n"
  end

  def board_row(y, style)
    #if style = :pegs, this prints only pegs. Otherwise, it prints ships also
    row_string = ("A".."J").to_a[y] #Place letter at front of row string
    @cell_grid[y].each do |cell| #Place visual cell graphics in row string
      row_string += " "
      if style == :pegs
        row_string += cell.peg
      end
      #else
      #  if cell.peg == " " && cell.ship
      #    row_string += "S"
      #  else
      #    row_string += cell.peg
      #  end #if
      #end # else
    end # each loop
    row_string += "\n"
  end # board_row
end

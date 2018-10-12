class Board
  attr_reader :cell_grid, :ship_array

  def initialize
    @cell_grid = generate_grid
    @ship_array = initialize_ships
  end

  def generate_grid
    ("A".."J").map do |y|
      (1..10).map { |x| Cell.new(y + x.to_s) }
    end
  end

  def initialize_ships
    ship_specs = [ {name: "Destroyer", size: 2},
                  {name: "Submarine", size: 3},
                  {name: "Cruiser", size: 3},
                  {name: "Battleship", size: 4},
                  {name: "Carrier", size: 5} ]
    ship_specs.map { |spec| Ship.new(spec[:name], spec[:size]) }
  end

### METHODS HAVING TO DO WITH PLACING SHIPS ###

  def place_ship(ship, prow, stern)
    #ship is an objet of the Ship class
    #prow and stern are strings as input by the user, ie. "J4"
    points = [{y: y_coord(prow),  x: x_coord(prow)},
              {y: y_coord(stern), x: x_coord(stern)}]
    error = placement_error_check(ship, points)
    return error if error != nil
    record_ship_in_cells(ship, points)
    nil #return if no error
  end
  def placement_error_check(ship, points)
    return :orientation_error if direction(points) == :diagonal
    return :length_error if span(points) != ship.size
    return :overlap_error if overlap_with_existing?(points)
    nil
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

### HELPER METHODS FOR SHIP PLACEMENT ERROR DETECTION ###

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

### METHOD FOR REGISTERING A SHOT ###

  def register_shot(cell_name)
    target_cell = @cell_grid[y_coord(cell_name)][x_coord(cell_name)]
    target_cell.place_peg
    #returns :duplicate_shot_error if cell was already fired upon
    #otherwise, it returns the value of peg in the target cell
    #These returns come from the cell.place_peg method
  end

### METHODS FOR PRINTING THE BOARD ###

  def print_board(style = :visible)
    #if style = :hidden, then ships are not shown
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
    board_string += board_key(style)
    board_string += "\n"
  end
  def border
    "=======================\n"
  end
  def header_row
    ". 1 2 3 4 5 6 7 8 9 10\n"
  end
  def board_row(y, style)
    #if style = :hidden, ships are not shown
    row_string = ("A".."J").to_a[y] #Place letter at front of row string
    @cell_grid[y].each do |cell| #Place visual cell graphics in row string
      row_string += " "
      if style == :hidden
        row_string += cell.peg
      else
        if cell.peg == " " && cell.ship
          row_string += "S"
        else
          row_string += cell.peg
        end #if
      end # else
    end # each loop
    row_string += "\n"
  end # board_row
  def board_key(style)
    #if style = :hidden, the ship key is not added
    key_string = style != :hidden ? "S = Ship  " : ""
    key_string += "X = Hit  * = Miss\n"
  end

### GENERAL UTILITY METHODS FOR CLASS ###

  def get_start_index(points)
    # When preparing to enumerate between two cells, this method
    # gets the index for starting enumeration, whether the two cells
    # are in horizontal or vertical orientation.
    # The starting cell is the lower of the two, so that the
    # enumeration can always proceed in a positive (+1) direction.
    if direction(points) == :horizontal
      points[1][:x] > points[0][:x] ? points[0][:x] : points[1][:x]
    else
      points[1][:y] > points[0][:y] ? points[0][:y] : points[1][:y]
    end
  end
  def y_coord(cell_name)
    ("A".."J").to_a.index(cell_name[0])
  end
  def x_coord(cell_name)
    cell_name[1..-1].to_i - 1
  end

end #class

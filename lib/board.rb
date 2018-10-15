require './lib/cell'
require './lib/ship'
require './lib/colors'

class Board
  attr_reader :cell_grid, :ship_array

### INITIALIZATION AND SETUP METHODS ###

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
    # is line 40 necessary? What do lines 38 and 39 return?
  end

  def placement_error_check(ship, points)
    return :orientation_error if direction(points) == :diagonal
    return :length_error if span(points) != ship.size
    return :overlap_error if overlap_with_existing?(points)
    nil
      # is line 48 necessary? What does this method return if lines 45, 46 and 47 are not executed?
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

 # I guess you needed the register_shot to test your board functionality in the temporary runner file. And that's perfectly fine for now. But it seems very repetitive that this method just calls place_peg and then we have to call register_shot from our player as well. We can just call cell.place_peg from player or the board. We also need to remember that  when we place a peg we're doing it on the opposite player's board. When we display ballistics it's also from the opposite player's board, not from ours.


  def register_shot(cell_name)

    cell = @cell_grid[y_coord(cell_name)][x_coord(cell_name)]
    result = cell.place_peg
    #returns :duplicate_shot_error if cell was already fired upon
    #otherwise, it returns the value of peg in the target cell
    cell.ship.hit! if result == "X"
    result
  end

### METHODS FOR CREATING A VISUAL GRID ARRAY ###
  # Returns an array of 10 strings, which can be printed
  # as sequential rows to show the current state of the board

  def visual_grid(style = :show_ships)
    visual_rows = []
    y = 0
    while y <= 9 do
      if style == :show_ships
        visual_rows[y] = visual_row(y, :show_ships)
      else #style == :hide_ships or anything else
        visual_rows[y] = visual_row(y, :hide_ships)
      end
      y += 1
    end
    visual_rows
  end
  def visual
    { miss:             "*".black.bg_cyan,
      ocean:            " ".bg_cyan,
      sunk:             " ".bg_blue,
      sunk_x:           "X".white.bg_blue,
      hidden_ship_hit:  "X".bold.red.bg_cyan,
      shown_ship:       "S".black.bg_gray,
      shown_ship_hit:   "X".bold.red.bg_gray,
      ship_color:       " ".bg_gray
    }
  end
  def visual_row(y, style)
    # Place leading space at beginning of row
    row_string = leading_space(y, style)
    x = 0
    @cell_grid[y].each do |cell|
      #First place the single symbolic charactor or space
      row_string << visual[ graphic_type(cell, style) ]
      #Then place the space following the above
      next_cell = x == 9 ? nil : @cell_grid[y][x + 1]
      row_string << visual[ space_type(cell, next_cell, style) ]
      x += 1
    end
    row_string
  end # ships_row
  def graphic_type(cell, style)
    return :miss if cell.peg == "*"
    return :ocean if cell.peg == " " && cell.ship == nil
    #fter the above returns, we know the cell has a ship
    return :sunk_x if cell.ship.sunk?
    if style == :hide_ships
     return :ocean if cell.peg == " " #hidden but un-hit
     return :hidden_ship_hit #cell.peg == "X"
    end
    #After the above returns, the cell must have an unhidden ship
    return :shown_ship if cell.peg == " "
    :shown_ship_hit #cell.peg == "X"
  end
  def space_type(cell, next_cell, style)
    if cell.ship == nil && (next_cell == nil || next_cell.ship == nil)
    #if neither side is a ship
      return :ocean
    end
    #After the above return, at least one side is a ship
    if style == :hide_ships
      #:sunk if either side is a sunk ship
      return :sunk if cell.ship && cell.ship.sunk? ||
            (next_cell != nil && next_cell.ship && next_cell.ship.sunk?)
      return :ocean #if hide ships and neither side is sunk ship
    else #style == :show_ships
      #:ship_color if either side is an unsunk ship
      return :ship_color if cell.ship && !cell.ship.sunk? ||
                            (next_cell.ship && !next_cell.ship.sunk?)
      return :sunk #if there's a ship, but no unsunk ones
    end
  end
  def leading_space(y, style)
    # if the first cell contains a ship, the front border is ship
    # or sunk color; otherwise it's ocean color.
    if @cell_grid[y][0].ship #if there's a ship on cell 0
      return visual[:sunk] if @cell_grid[y][0].ship.sunk?
      return visual[:ship_color] if style == :show_ships
    end
    visual[:ocean] #if anything else, including hidden ship
  end

### GENERAL UTILITY METHODS FOR BOARD CLASS ###
  def get_start_index(points)
    # When preparing to enumerate between two cells, this method
    # gets the index for starting enumeration, whether the two cells
    # are in horizontal or vertical orientation. The starting cell
    # has the lower array index of the two, so that the
    # enumeration can always proceed in a positive (+1) direction.
    if direction(points) == :horizontal
      points[1][:x] > points[0][:x] ? points[0][:x] : points[1][:x]
    else
      points[1][:y] > points[0][:y] ? points[0][:y] : points[1][:y]
    end
  end

  # We have the following methods duplicated in Cell. Do we need to keep both?
  def y_coord(cell_name)
    ("A".."J").to_a.index(cell_name[0])
  end

  def x_coord(cell_name)
    cell_name[1..-1].to_i - 1 #how about cell_name[1] since we're not looking through a range? We're just calling the second element in a string.
  end

end #class Board

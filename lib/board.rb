require './lib/cell'

# This class requires access to the Cell & Ship classes

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
    @cell_grid[y_coord(cell_name)][x_coord(cell_name)].place_peg
    #returns :duplicate_shot_error if cell was already fired upon
    #otherwise, it returns the value of peg in the target cell
    #These returns come from the cell.place_peg method
  end

### METHODS FOR CREATING A VISUAL GRID ARRAY ###
# Returns an array of 10 strings, which can be printed
# as sequential rows to show the current state of the board

  def visual_grid(style)
    visual_rows = []
    y = 0
    while y <= 9 do
      if style == :balistics
        visual_rows[y] = balistics_row(y)
      else #style == :ships or anything else
        visual_rows[y] = ships_row(y)
      end
      y += 1
    end
    visual_rows
  end

  def balistics_row(y)
    row_string = " ".bg_cyan #lead row with cyan border
    @cell_grid[y].each do |cell| #For each cell in this row
      #Place the appropriate symbol or space
      if cell.peg == "X"
        row_string += "X".bold.red.bg_cyan
      else
        row_string += graphical(cell.peg)
      end
      #Follow with a cyan space
      row_string += " ".bg_cyan
    end
    row_string
  end

  def ships_row(y)
    row_string = leading_space(y)
    x = 0
    @cell_grid[y].each do |cell|
      # First place the single symbolic charactor or space
      if cell.ship && cell.peg == " " #if ship; and cell not hit

      # cell.ship will either be a a ship object or nil, never a string so the condition should read : if cell.ship == nil && cell.peg = " "

        row_string += "S".black.bg_gray
      else
        row_string += graphical(cell.peg)
      end
      # Then place the space following the above
      if cell.ship || (x != 9 && @cell_grid[y][x + 1].ship)
        #if this or the following cell is a ship
        row_string += " ".bg_gray
      else
        row_string += " ".bg_cyan
      end
      x += 1
    end
    row_string
  end # ships_row

  def leading_space(y)
    # if the first cell contains a ship, the front border is ship color,
    # otherwise it's sea color.
    @cell_grid[y][0].ship ? " ".bg_gray : " ".bg_cyan
  end

  def graphical(peg)
    return " ".bg_cyan if peg == " "
    return "*".black.bg_cyan if peg == "*"
    return "X".bold.red.bg_gray if peg == "X"
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

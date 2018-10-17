class Brainiac

  def autoplace_all_ships(board)
    ship_count = board.ship_array.count
    i = 0
    ship_count.times do #5 times for 5 ships
      autoplace_ship(board, i)
      i += 1
    end
    nil
  end

  def autoplace_ship(board, ship_index)
    points = []
    begin
      orientation = random_orientation
      ship_size = board.ship_array[ship_index].size
      prow_coords = random_prow_coords(ship_size, orientation)
      stern_coords = find_stern(prow_coords, ship_size, orientation)
      points = [prow_coords, stern_coords]
      overlap = board.overlap_with_existing?(points)
    end until !overlap
    board.record_ship_in_cells(board.ship_array[ship_index], points)
  end
  def random_orientation
    return :horizontal if rand(2) == 0
    :vertical
  end
  def random_prow_coords(ship_size, orientation)
    board_size = 10
    max_start = board_size - ship_size + 1
    short = rand(max_start)
    long = rand(10)
    orientation == :horizontal ? {y: long, x: short} : {y: short, x: long}
  end
  def find_stern(prow_coords, ship_size, orientation)
    if orientation == :horizontal
      {y: prow_coords[:y], x: prow_coords[:x] + ship_size - 1}
    else #if vertical
      {y: prow_coords[:y] + ship_size -1, x: prow_coords[:x]}
    end
  end

  def intelliguess(board) #returns string of form "J4"
    load_floaters(board) #load array of un-sunk ships types
    @pgrid = load_pgrid(board) #initialize probability grid
    horizontal_probabilities #add all horizontal probabilities
    vertical_probabilities #add all vertical probabilities
    #print_pgrid #error testing method
    load_live_hits(board) #load array of hits-not-sunk
    #print @hits
    #print "\n"
    b = find_best_shot(board) #returns two elemnt array by grid_coords
    guess = yx_to_name({y: b[0], x: b[1]})
    #print guess + "\n"
    guess
  end

  def find_best_shot(board)
    best_shot = [0,0]
    if @hits.count == 0
      best_in_pgrid(board)
    else
      best_near_hits(board)
    end
  end

  def best_near_hits(board)
    surrounds = [ [0,1], [0,-1], [1,0], [-1,0] ]
    best = []
    @hits.each do |hit|
      surrounds.each do |surround|
        shot = [hit[0] + surround[0], hit[1] + surround[1]]
        if valid_shot?(board, shot)
          if best == [] || @pgrid[shot[0]][shot[1]] > @pgrid[best[0]][best[1]]
            best = shot
          end
        end
      end
    end
    best
  end

  def valid_shot?(board, shot)
    return false if shot[0] < 0 || shot[0] > 9
    return false if shot[1] < 0 || shot[1] > 9
    cell = board.cell_grid[shot[0]][shot[1]]
    return false if cell.peg == "X" || cell.peg == "*"
    true
  end

  def best_in_pgrid(board)
    best = []
    (0..9).each do |y|
      (0..9).each do |x|
        if @pgrid[y][x] != nil &&
        (best == [] || @pgrid[y][x] > @pgrid[best[0]][best[1]])
          best = [y,x]
        end
      end
    end
    best
  end

  def load_live_hits(board)
    @hits = []
    (0..9).each do |y|
      (0..9).each do |x|
        cell = board.cell_grid[y][x]
        if cell.peg == "X" && cell.ship.sunk? == false
          @hits << [y,x]
        end
      end
    end
  end

  def load_pgrid(board)
    (0..9).map do |y|
      (0..9).map do |x|
        cell = board.cell_grid[y][x]
        if (cell.ship != nil && cell.ship.sunk?) || cell.peg == "*"
          nil #if there's no possibility of a live ship on this space
        else
          0 #if there could be a live ship on this space
        end
      end
    end
  end

  def load_floaters(board)
    @floaters = { 2 => 0, 3 => 0, 4 => 0, 5 => 0 }
    ships = board.ship_array
    @floaters[2] = 1 if ships[0].sunk? == false
    @floaters[3] = 1 if ships[1].sunk? == false
    @floaters[3] += 1 if ships[2].sunk? == false
    @floaters[4] = 1 if ships[3].sunk? == false
    @floaters[5] = 1 if ships[4].sunk? == false
  end

  def horizontal_probabilities
    (2..5).each do |ship_size| #for each ship size still floating
      if @floaters[ship_size] > 0
        (0..9).each do |y| #for each row y
          x_max = 9 - ship_size + 1
          (0..x_max).each do |x| #for each possible prow x
            if horz_ship_fits?(y, x, ship_size)
              horz_add_probs(y, x, ship_size) #add 1 to each ship square
            end
          end
        end
      end
    end
  end
  def horz_ship_fits?(y, prow, ship_size)
    stern = prow + ship_size - 1
    (prow..stern).each do |x|
      return false if @pgrid[y][x] == nil
    end
    true
  end
  def horz_add_probs(y, prow, ship_size)
    stern = prow + ship_size - 1
    (prow..stern).each do |x|
      @pgrid[y][x] += @floaters[ship_size] #adds the number floating ships
    end
  end

  def vertical_probabilities
    (2..5).each do |ship_size| #for each ship size still floating
      if @floaters[ship_size] > 0
        (0..9).each do |x| #for each column x
          y_max = 9 - ship_size + 1
          (0..y_max).each do |y| #for each possible prow y
            if vert_ship_fits?(y, x, ship_size)
              vert_add_probs(y, x, ship_size) #add 1 to each ship square
            end
          end
        end
      end
    end
  end
  def vert_ship_fits?(prow, x, ship_size)
    stern = prow + ship_size - 1
    (prow..stern).each do |y|
      return false if @pgrid[y][x] == nil
    end
    true
  end
  def vert_add_probs(prow, x, ship_size)
    stern = prow + ship_size - 1
    (prow..stern).each do |y|
      @pgrid[y][x] += @floaters[ship_size] #adds the number floating ships
    end
  end

  def print_pgrid #simply an error testing function
    (0..9).each do |y|
      (0..9).each do |x|
        if @pgrid[y][x] == nil
          printf("%2d ", 0)
          #print "N "
        else
          #print @pgrid[y][x]
          printf("%2d ", @pgrid[y][x])
        end
      end
      print "\n"
    end
  end

  def yx_to_name(point) #where point is hash with :y & :x
    y_char = ("A".."J").to_a[point[:y]]
    x_char = (point[:x] + 1).to_s
    y_char + x_char
  end

end #class Brainiac

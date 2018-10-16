class Brainiac

  def autoplace_all_ships(board)
    ship_count = board.ship_array.count
    i = 0
    ship_count.times do #5 times for 5 ships
      autoplace_ship(board, i)
      i += 1
      print "Placed #{i}"
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

end #class Brainiac

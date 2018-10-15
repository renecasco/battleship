class Display

  def standard_gap
    "      "
  end

  def ships_title
    "        S H I P S      ".bold.green
  end

  def ships_underscore
    "        =========      "
  end

  def balistics_title
    "    B A L I S T I C S  ".bold.green
  end

  def balistics_underscore
    "    =================  "
  end

  def header_row
    "   1 2 3 4 5 6 7 8 9 10"
  end

  def board_key
    #All keys start with Ship
    key_string = "        " + " S ".black.bg_gray + " = Ship  "
    key_string += " X ".bold.red.bg_cyan + " = Hit  "
    key_string += " * ".black.bg_cyan + " = Miss"
  end

  def show_ship_placement(board)
  #This method simply uses the :ship style of the visual grid. To show
  #the ship bositions at the beginning of a round, the board must be free
  #of hits and misses.
    print "\n\n"
    print ships_title + "\n"
    print ships_underscore + "\n\n"
    print header_row + "\n"

    visual_grid = board.visual_grid(:ships)
    y = 0
    visual_grid.each do |visual_row|
      print ("A".."J").to_a[y] #Place letter at front of row string
      print " " + visual_row + "\n"
      y += 1
    end
    print "\n"
  end

  def show_console(own_board, enemy_board)
  #This method shows the entire player console, with both Ships
  #(friendly waters), and Balistics (enemy waters)
    print "\n\n"
    print ships_title + standard_gap + balistics_title + "\n"
    print ships_underscore + standard_gap + balistics_underscore + "\n\n"
    print header_row + standard_gap + header_row + "\n"

    own_grid = own_board.visual_grid(:ships)
    enemy_grid = enemy_board.visual_grid(:balistics)
    y = 0
    10.times do
      print ("A".."J").to_a[y] #Place letter at front of row string
      print " " + own_grid[y] + standard_gap
      print ("A".."J").to_a[y]
      print " " + enemy_grid[y] + "\n"
      y += 1
    end
    print "\n" + board_key + "\n\n"
  end

end

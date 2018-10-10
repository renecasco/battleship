class Ship
  attr_reader :name,
              :length,
              :hit_count

  # I removed the starting cell and end cell because on Sal's line of thought the board (through it's cells already knows which cells contain the ship). Also we discussed  the possibility of giving the responsibility of placing ships to the board. So doing board.place_ship(start_cell, end_cell) makes more sense! Once a peg is placed on a cell that contains a ship we would call ship.hit! to increment ship.hit_count and then ship.sunk? that compares the hit_count to the length of the ship and returns a boolean wether it was sunk or not.


  # Also we define the name and length of the ships, not the user, example given in the test.

  def initialize(name, length)
    @name = name
    @length = length
    @hit_count = 0
  end

  def hit!
    @hit_count += 1
  end

  def sunk?
    if @hit_count == length
      true
    else
      false
    end
  end


end

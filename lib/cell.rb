require './lib/ship'

class Cell
  attr_reader :name,
              :contents,
              :peg

  def initialize(name)
    @name = name
    @contents = nil
    @peg = nil
  end

# I think we're overcomplicating here, peg value should be the same as the output for get_row. That way we would save ourselves a few lines of code and processing time of 'if' statements in get_row if we use "W" and "R" or "H" or "M" instead of :miss and :hit. We would only call the value stored in peg. In that same line of thought, peg should be initialized with a space " ". We wouldn't need to make all those decsisions or conversions to output to screen on print_board / get_row. Let's keep it simple.

  def place_peg
    if @contents == nil
      @peg = :miss
    else
      @peg = :hit
    end
  end

  def change_contents(ship)
    @contents = ship
  end
end

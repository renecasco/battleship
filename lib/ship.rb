class Ship
  attr_reader :start_cell,
              :end_cell

  def initialize(start_cell, end_cell, name)
    @start_cell = start_cell
    @end_cell = end_cell
  end
end

require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell'

class CellTest < Minitest::Test

  def test_it_exists
    cell = Cell.new("A1")
    assert_instance_of Cell, cell
  end

  def test_it_has_attributes
    cell = Cell.new("A1")
    assert_equal "A1", cell.name
    assert_nil cell.ship
    assert_equal " ", cell.peg
  end

  def test_it_contains_ship
    cell = Cell.new("A1")
    ship = Ship.new("A1", "A2", "Aircraft Carrier")
    cell.add_ship(ship)
    actual = cell.ship
    expected = ship
    assert_equal expected, actual
  end

  def test_it_places_peg
    cell = Cell.new("A1")
    ship = Ship.new("A1", "A2", "Aircraft Carrier")
    assert_equal "W", cell.place_peg
    cell.add_ship(ship)
    assert_equal "R", cell.place_peg
  end

  def test_it_returns_grid_y
    cell_0 = Cell.new("A1")
    cell_1 = Cell.new("C5")
    cell_2 = Cell.new("J10")
    assert_equal 0, cell_0.grid_y
    assert_equal 2, cell_1.grid_y
    assert_equal 9, cell_2.grid_y
  end

  def test_it_returns_grid_x
    cell_0 = Cell.new("A1")
    cell_1 = Cell.new("C5")
    cell_2 = Cell.new("J10")
    assert_equal 0, cell_0.grid_x
    assert_equal 4, cell_1.grid_x
    assert_equal 9, cell_2.grid_x
  end

end

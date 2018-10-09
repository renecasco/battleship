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
    assert_equal nil, cell.contents
    assert_equal nil, cell.peg
  end

  def test_it_places_peg
    cell = Cell.new("A1")
    actual = cell.place_peg(:hit)
    expected = :hit
    assert_equal expected, actual
  end

  def test_it_points_to_ship
    cell = Cell.new("A1")
    ship = Ship.new("A1", "A2", "Aircraft Carrier")
    actual = cell.point_to_ship(ship)
    expected = ship
    assert_equal expected, actual
  end

end

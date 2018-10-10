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

  def test_it_changes_contents
    cell = Cell.new("A1")
    ship = Ship.new("Destroyer", 2)
    actual = cell.add_ship(ship)
    expected = ship
    assert_equal expected, actual
  end

  def test_it_places_hit_peg
    cell = Cell.new("A1")
    ship = Ship.new("Destroyer", 2)
    cell.add_ship(ship)
    actual = cell.place_peg
    expected = "R"
    assert_equal expected, actual
  end

  def test_it_places_miss_peg
    cell = Cell.new("A1")
    actual = cell.place_peg
    expected = "W"
    assert_equal expected, actual
  end

end

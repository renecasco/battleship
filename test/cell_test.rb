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
    assert_nil cell.contents
    assert_nil cell.peg
  end

  def test_it_changes_contents
    cell = Cell.new("A1")
    ship = Ship.new("A1", "A2", "Aircraft Carrier")
    actual = cell.change_contents(ship)
    expected = ship
    assert_equal expected, actual
  end

  def test_it_places_hit_peg
    cell = Cell.new("A1")
    ship = Ship.new("A1", "A2", "Aircraft Carrier")
    cell.change_contents(ship)
    actual = cell.place_peg
    expected = :hit
    assert_equal expected, actual
  end

  def test_it_places_miss_peg
    cell = Cell.new("A1")
    actual = cell.place_peg
    expected = :miss
    assert_equal expected, actual
  end

end

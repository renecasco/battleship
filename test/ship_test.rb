require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'

class ShipTest < Minitest::Test

  def test_it_exists
    ship = Ship.new("A1", "A2", "Aircraft Carrier")
    assert_instance_of Ship, ship
  end

  def test_it_has_attributes
    ship = Ship.new("A1", "A2", "Aircraft Carrier")
    assert_equal "A1", ship.start_cell
    assert_equal "A2", ship.end_cell
  end
end

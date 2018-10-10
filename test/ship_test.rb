require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'

class ShipTest < Minitest::Test

  def test_it_exists
    destroyer = Ship.new("Destroyer", 2)
    submarine = Ship.new("Submarine", 3)
    assert_instance_of Ship, destroyer
    assert_instance_of Ship, submarine
  end

  def test_it_has_attributes
    destroyer = Ship.new("Destroyer", 2)
    assert_equal "Destroyer", destroyer.name
    assert_equal 2, destroyer.length
    assert_equal 0, destroyer.hit_count
  end

  def test_hit_increments_hit_count
    destroyer = Ship.new("Destroyer", 2)
    assert_equal "Destroyer", destroyer.name
    assert_equal 0, destroyer.hit_count
    destroyer.hit!
    assert_equal 1, destroyer.hit_count
  end

  def test_ship_gets_sunk
    destroyer = Ship.new("Destroyer", 2)
    assert_equal "Destroyer", destroyer.name
    assert_equal 0, destroyer.hit_count
    destroyer.hit!
    assert_equal 1, destroyer.hit_count
    assert_equal false, destroyer.sunk?
    destroyer.hit!
    assert_equal 2, destroyer.hit_count
    assert_equal true, destroyer.sunk?
  end


end

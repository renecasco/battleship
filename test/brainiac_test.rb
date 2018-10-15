require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/brainiac'
require 'pry'

class BrainiacTest < Minitest::Test
  def setup
    @board = Board.new
    @brainiac = Brainiac.new
  end
  def init_with_ships
    @board.place_ship(@board.ship_array[0], "D10", "C10")
    @board.place_ship(@board.ship_array[1], "G4", "G6")
    @board.place_ship(@board.ship_array[2], "G8", "I8")
    @board.place_ship(@board.ship_array[3], "A1", "A4")
    @board.place_ship(@board.ship_array[4], "E3", "I3")
  end
  def init_with_shots
    @board.register_shot("D7")
    @board.register_shot("H3")
    @board.register_shot("I2")
    @board.register_shot("B9")
    @board.register_shot("A1")
    @board.register_shot("A2")
    @board.register_shot("H7")
    @board.register_shot("I9")
    @board.register_shot("G6")
    @board.register_shot("C2")
    @board.register_shot("J6")
    @board.register_shot("H8")
    @board.register_shot("I3")
    @board.register_shot("E3")
    @board.register_shot("D10")
  end

  def test_it_exists
    assert_instance_of Brainiac, @brainiac
  end
  def test_it_autoplaces_ships
  end

end #BrainiacTest

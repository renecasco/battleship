require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/colors'
require 'pry'

class BoardTest < Minitest::Test
  def setup
    @board = Board.new
  end
  def init_with_ships_n_shots
    place_four_ships
    #place the final ship
    @board.place_ship(@board.ship_array[4], "E3", "I3")
    make_a_bunch_of_shots
    @board.register_shot("D7")
    @board.register_shot("H3")
    @board.register_shot("I2")
    @board.register_shot("B9")
  end
  def place_four_ships
    @board.place_ship(@board.ship_array[0], "D10", "C10")
    @board.place_ship(@board.ship_array[1], "G4", "G6")
    @board.place_ship(@board.ship_array[2], "G8", "I8")
    @board.place_ship(@board.ship_array[3], "A1", "A4")
  end
  def make_a_bunch_of_shots
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
    assert_instance_of Board, @board
  end
  def test_it_has_proper_array_lengths
    assert_equal 10, @board.cell_grid.length
  end
  def test_it_generates_grid_names
    assert_equal "A1", @board.cell_grid[0][0].name
    assert_equal "C4", @board.cell_grid[2][3].name
  end
  def test_it_initializes_ships
    assert_equal 5, @board.ship_array.length
    assert_equal "Destroyer", @board.ship_array[0].name
    assert_equal 2, @board.ship_array[0].size
    assert_equal "Carrier", @board.ship_array[4].name
    assert_equal 5, @board.ship_array[4].size
  end
  def test_it_places_ships
    place_four_ships
    #test the third ship placed (the "Cruiser")
    assert_equal "Cruiser", @board.cell_grid[6][7].ship.name
    assert_equal "Cruiser", @board.cell_grid[7][7].ship.name
    assert_equal "Cruiser", @board.cell_grid[8][7].ship.name
    #place the final ship
    @board.place_ship(@board.ship_array[4], "E3", "I3")
    #test the final ship (the "Carrier")
    assert_equal "Carrier", @board.cell_grid[4][2].ship.name
    assert_equal "Carrier", @board.cell_grid[6][2].ship.name
    assert_equal "Carrier", @board.cell_grid[8][2].ship.name
  end
  def test_it_returns_ship_placement_errors
    place_four_ships
    #ships placed with orientation error
    assert_equal :orientation_error, @board.place_ship(@board.ship_array[4], "D10", "C9")
    assert_equal :orientation_error, @board.place_ship(@board.ship_array[4], "G4", "A6")
    #ships placed with length error (horizontal & vertical)
    assert_equal :length_error, @board.place_ship(@board.ship_array[4], "E3", "H3")
    assert_equal :length_error, @board.place_ship(@board.ship_array[4], "D2", "D8")
    #ships placed with overlap error (horizontal & vertical)
    assert_equal :overlap_error, @board.place_ship(@board.ship_array[4], "E4", "I4")
    assert_equal :overlap_error, @board.place_ship(@board.ship_array[4], "A4", "A8")
  end
  def test_it_returns_shot_errors
    place_four_ships
    #place the final ship
    @board.place_ship(@board.ship_array[4], "E3", "I3")
    make_a_bunch_of_shots
    assert_equal :duplicate_shot_error, @board.register_shot("A2")
    assert_equal :duplicate_shot_error, @board.register_shot("J6")
    assert_equal :duplicate_shot_error, @board.register_shot("I9")
    assert_equal :duplicate_shot_error, @board.register_shot("E3")
  end
  def test_it_places_shots
    place_four_ships
    #place the final ship
    @board.place_ship(@board.ship_array[4], "E3", "I3")
    make_a_bunch_of_shots
    assert_equal "*", @board.register_shot("D7")
    assert_equal "X", @board.register_shot("H3")
    assert_equal "*", @board.register_shot("I2")
    assert_equal "*", @board.register_shot("B9")
  end
  def test_it_returns_visual_grid
    init_with_ships_n_shots
    assert_equal 10, @board.visual_grid(:ships).count
  end

end #BoardTest

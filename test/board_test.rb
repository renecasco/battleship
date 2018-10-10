require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require 'pry'

class BoardTest < Minitest::Test

  def test_it_exists
    board = Board.new
    assert_instance_of Board, board
  end

  def test_it_has_proper_array_lengths
    board = Board.new
    assert_equal 10, board.cell_grid.length
  end

  def test_it_generates_grid_names
    board = Board.new
    assert_equal "A1", board.cell_grid[0][0].name
    assert_equal "C4", board.cell_grid[2][3].name
  end

  def test_it_assembles_board_string
    board = Board.new
    actual = board.get_board_string
    expected =
"=======================
. 1 2 3 4 5 6 7 8 9 10
A\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s
B\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s
C\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s
D\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s
E\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s
F\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s
G\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s
H\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s
I\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s
J\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s
=======================\n"

    assert_equal expected, actual
  end

end

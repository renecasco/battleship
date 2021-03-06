require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require './lib/player'

class PlayerTest < Minitest::Test

  def test_it_exists
    board_1 = Board.new
    player_1 = Player.new("Joe", board_1, "human")
    assert_instance_of Player, player_1
  end

  def test_it_has_attributes
    board_1 = Board.new
    player_1 = Player.new("Joe", board_1, "human")
    assert_equal board_1, player_1.board
    assert_equal "Joe", player_1.name
    assert_equal "human", player_1.player_type
  end

end

require './lib/board'
require './lib/ship'
require './lib/cell'
require './lib/colors'
require './lib/display'
require './lib/brainiac'
require 'pry'

display = Display.new
brainiac = Brainiac.new

def take_turn(player_name, turn_number, own_board, enemy_board)
  brainiac = Brainiac.new
  display = Display.new
  guess = brainiac.intelliguess(enemy_board) #guess is a cell name, ie J4
  result = enemy_board.register_shot(guess)
  display.show_console(own_board, enemy_board)
  print "#{player_name}, Turn #{turn_number}. Guess: #{guess}\n"
  if result == "X"
    print "HIT! "
    ship_name = enemy_board.sunk_ship_name?(guess)
    if ship_name != nil
      print "You sunk a " + ship_name + "!   "
      if enemy_board.defeated?
        return :victory
      end
    end
  end
  print "\n"
  :continue
end

total_turns = 0
(1..1000).each do |game_number|
  board_1 = Board.new
  board_2 = Board.new

  brainiac.autoplace_all_ships(board_1)
  display.show_ship_placement(board_1)

  brainiac.autoplace_all_ships(board_2)
  display.show_ship_placement(board_2)

  turn_number = 0
  winner = nil
  begin
    turn_number += 1
    if take_turn("Player One", turn_number, board_1, board_2) == :victory
      winner = "Player One"
    elsif take_turn("Player Two", turn_number, board_2, board_1) == :victory
      winner = "Player Two"
    end
  end until winner != nil
  print "\nGame Number #{game_number}.\n"
  print "#{winner} is victorious!!!\n"
  total_turns += turn_number
end
average_turns_per_game = total_turns / 1000
print "\nAverage turns per game: #{average_turns_per_game}\n"

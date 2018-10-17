require './lib/board'
require './lib/ship'
require './lib/cell'
require './lib/colors'
require './lib/display'
require './lib/brainiac'
require 'pry'

display = Display.new
computer_board = Board.new
human_board = Board.new
brainiac = Brainiac.new

brainiac.autoplace_all_ships(computer_board)


#first four ships properly placed
human_board.place_ship(human_board.ship_array[0], "D10", "C10")
human_board.place_ship(human_board.ship_array[1], "G4", "G6")
human_board.place_ship(human_board.ship_array[2], "G8", "I8")
human_board.place_ship(human_board.ship_array[3], "A1", "A4")

#ships placed with orientation error
human_board.place_ship(human_board.ship_array[4], "D10", "C9")
human_board.place_ship(human_board.ship_array[4], "G4", "A6")
#ships placed with length error (horizontal & vertical)
human_board.place_ship(human_board.ship_array[4], "E3", "H3")
human_board.place_ship(human_board.ship_array[4], "D2", "D8")
#ships placed with overlap error (horizontal & vertical)
human_board.place_ship(human_board.ship_array[4], "E4", "I4")
human_board.place_ship(human_board.ship_array[4], "A4", "A8")

#final ship properly placed
human_board.place_ship(human_board.ship_array[4], "E3", "I3")

display.show_ship_placement(human_board)
display.show_ship_placement(computer_board)


#shots properly made
human_board.register_shot("A1")
human_board.register_shot("A2")
human_board.register_shot("H7")
human_board.register_shot("I9")
human_board.register_shot("G6")
human_board.register_shot("C2")
human_board.register_shot("J6")
human_board.register_shot("H8")
human_board.register_shot("I3")
human_board.register_shot("E3")
human_board.register_shot("D10")
#duplicate shots
human_board.register_shot("A2")
human_board.register_shot("J6")
human_board.register_shot("I9")
human_board.register_shot("E3")
#more proper shots
human_board.register_shot("D7")
human_board.register_shot("H3")
human_board.register_shot("I2")
human_board.register_shot("B9")

human_board.register_shot("G4")
human_board.register_shot("G5")

#shots properly made
computer_board.register_shot("A4")
computer_board.register_shot("A1")
computer_board.register_shot("H8")
computer_board.register_shot("I4")
computer_board.register_shot("G6")
computer_board.register_shot("C2")
computer_board.register_shot("J3")
computer_board.register_shot("H8")
computer_board.register_shot("I9")
computer_board.register_shot("E3")
computer_board.register_shot("D10")
#duplicate shots
computer_board.register_shot("H8")
computer_board.register_shot("I9")
computer_board.register_shot("D10")
computer_board.register_shot("H8")
#more proper shots
computer_board.register_shot("D2")
computer_board.register_shot("H3")
computer_board.register_shot("I10")
computer_board.register_shot("B7")

computer_board.register_shot("F2")
computer_board.register_shot("F8")
computer_board.register_shot("I1")
computer_board.register_shot("I2")
computer_board.register_shot("I3")
computer_board.register_shot("I5")
computer_board.register_shot("I6")
computer_board.register_shot("I7")
computer_board.register_shot("I8")

computer_board.register_shot("A8")
computer_board.register_shot("B8")
computer_board.register_shot("C8")
computer_board.register_shot("D8")
computer_board.register_shot("E8")
computer_board.register_shot("G8")
computer_board.register_shot("J8")



display.show_console(human_board, computer_board)
brainiac.intelliguess(computer_board)

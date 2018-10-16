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
display.show_ship_placement(computer_board)


#first four ships properly placed
p human_board.place_ship(human_board.ship_array[0], "D10", "C10")
p human_board.place_ship(human_board.ship_array[1], "G4", "G6")
p human_board.place_ship(human_board.ship_array[2], "G8", "I8")
p human_board.place_ship(human_board.ship_array[3], "A1", "A4")

#ships placed with orientation error
p human_board.place_ship(human_board.ship_array[4], "D10", "C9")
p human_board.place_ship(human_board.ship_array[4], "G4", "A6")
#ships placed with length error (horizontal & vertical)
p human_board.place_ship(human_board.ship_array[4], "E3", "H3")
p human_board.place_ship(human_board.ship_array[4], "D2", "D8")
#ships placed with overlap error (horizontal & vertical)
p human_board.place_ship(human_board.ship_array[4], "E4", "I4")
p human_board.place_ship(human_board.ship_array[4], "A4", "A8")

#final ship properly placed
p human_board.place_ship(human_board.ship_array[4], "E3", "I3")

display.show_ship_placement(human_board)

#shots properly made
p human_board.register_shot("A1")
p human_board.register_shot("A2")
p human_board.register_shot("H7")
p human_board.register_shot("I9")
p human_board.register_shot("G6")
p human_board.register_shot("C2")
p human_board.register_shot("J6")
p human_board.register_shot("H8")
p human_board.register_shot("I3")
p human_board.register_shot("E3")
p human_board.register_shot("D10")
#duplicate shots
p human_board.register_shot("A2")
p human_board.register_shot("J6")
p human_board.register_shot("I9")
p human_board.register_shot("E3")
#more proper shots
p human_board.register_shot("D7")
p human_board.register_shot("H3")
p human_board.register_shot("I2")
p human_board.register_shot("B9")

p human_board.register_shot("G4")
p human_board.register_shot("G5")

#shots properly made
p computer_board.register_shot("A4")
p computer_board.register_shot("A1")
p computer_board.register_shot("H8")
p computer_board.register_shot("I4")
p computer_board.register_shot("G6")
p computer_board.register_shot("C2")
p computer_board.register_shot("J3")
p computer_board.register_shot("H8")
p computer_board.register_shot("I9")
p computer_board.register_shot("E3")
p computer_board.register_shot("D10")
#duplicate shots
p computer_board.register_shot("H8")
p computer_board.register_shot("I9")
p computer_board.register_shot("D10")
p computer_board.register_shot("H8")
#more proper shots
p computer_board.register_shot("D2")
p computer_board.register_shot("H3")
p computer_board.register_shot("I10")
p computer_board.register_shot("B7")

p computer_board.register_shot("F2")
p computer_board.register_shot("F8")

display.show_console(human_board, computer_board)

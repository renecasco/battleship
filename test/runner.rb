require './lib/board'
require './lib/ship'
require './lib/cell'
require 'pry'

board = Board.new

#first four ships properly placed
p board.place_ship(board.ship_array[0], "D10", "C10")
p board.place_ship(board.ship_array[1], "G4", "G6")
p board.place_ship(board.ship_array[2], "G8", "I8")
p board.place_ship(board.ship_array[3], "A2", "A5")

#ships placed with orientation error
p board.place_ship(board.ship_array[4], "D10", "C9")
p board.place_ship(board.ship_array[4], "G4", "A6")
#ships placed with length error (horizontal & vertical)
p board.place_ship(board.ship_array[4], "E3", "H3")
p board.place_ship(board.ship_array[4], "D2", "D8")
#ships placed with overlap error (horizontal & vertical)
p board.place_ship(board.ship_array[4], "E4", "I4")
p board.place_ship(board.ship_array[4], "A4", "A8")

#final ship properly placed
p board.place_ship(board.ship_array[4], "E3", "I3")

#shots properly made
p board.register_shot("A1")
p board.register_shot("A2")
p board.register_shot("H7")
p board.register_shot("I9")
p board.register_shot("G6")
p board.register_shot("C2")
p board.register_shot("J6")
p board.register_shot("H8")
p board.register_shot("I3")
p board.register_shot("E3")
p board.register_shot("D10")
#duplicate shots
p board.register_shot("A2")
p board.register_shot("J6")
p board.register_shot("I9")
p board.register_shot("E3")
#more proper shots
p board.register_shot("D7")
p board.register_shot("H3")
p board.register_shot("I2")
p board.register_shot("B9")

board.print_board(:hidden)
board.print_board

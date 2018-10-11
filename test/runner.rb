require './lib/board'
require './lib/ship'
require './lib/cell'
require 'pry'

board = Board.new

board.print_board(:hidden)
board.place_ship(board.ship_array[0], "D10", "C10")
board.place_ship(board.ship_array[1], "G4", "G6")
board.place_ship(board.ship_array[2], "G8", "I8")
board.place_ship(board.ship_array[3], "A2", "A5")
board.place_ship(board.ship_array[4], "E3", "I3")

board.print_board

board.register_shot("A1")
board.register_shot("A2")
board.register_shot("H7")
board.register_shot("I9")
board.register_shot("G6")
board.register_shot("C2")
board.register_shot("J6")
board.register_shot("H8")
board.register_shot("I3")
board.register_shot("E3")
board.register_shot("D10")

board.print_board(:hidden)
board.print_board

require './lib/player.rb'

def welcome
  puts "=".white.bg_cyan * 61
  puts "  ".bg_blue + "            ***   Welcome to BATTLESHIP  ***             ".red.bg_gray.bold  + "  ".bg_blue
  puts puts "=".white.bg_cyan * 61
  puts "Would you like to (" + "p".green.bold + ")lay, read the ("+ "i".green.bold + ")nstructions, or (" + "q".green.bold + ")uit?"
end

def instructions
  puts "\nShip Placement".green.bold
  puts " The first stage of the game is ship placement. Each player will\n take turns to place their fleet. You will be prompted to enter\n the coordinates for the prow and stern for each ship.\n Coordinates consist of a letter from A to J and a number from\n 1 to 10. (e.g.: B4, E7, C3, etc.)"
  puts "\nShot Sequence".green.bold
  puts " The second stage of the game is firing shots at the enemy's fleet.\n Players will take turns by entering coordinates in the format\n described above. Once again, you will be prompted each time your\n turn is up. The player who sinks all of the enemy's ships first\n wins the game."
end

def computer_placed_ships_msg
  puts "\n\nI have laid out my ships on the grid.\nYou now need to layout your ships.\nThe grid has A1 at the top left and J10 at the bottom right."
end

welcome
instructions
computer_placed_ships_msg

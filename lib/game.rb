require './lib/player'
require 'pry'

class Game

  def welcome
    puts
    puts "=".white.bg_cyan * 61
    puts "  ".bg_blue + "            ***   WELCOME TO BATTLESHIP  ***             ".red.bg_gray.bold  + "  ".bg_blue
    puts puts "=".white.bg_cyan * 61
  end

  def play
    answer = ""
    incorrect_input = false
    until answer == "Q"
      print "\nWould you like to (" + "p".green.bold + ")lay, read the ("+ "i".green.bold + ")nstructions, or (" + "q".green.bold + ")uit? "
      answer = gets.chomp.upcase
      if answer == "Q"
        puts "Sorry to see you go, thanks for playing Battleship!"
        break
      elsif answer == "I"
        instructions
      elsif answer == "P"
        lets_play
        break
      else
        puts "Not recognized. Please try again. "
      end
    end
  end

  def lets_play
    computer = Player.new("Brainiac", :ai)
    human = Player.new("Human", :human)
    computer.place_fleet
    computer_placed_ships_msg
    human.place_fleet

    turn_number = 0
    winner = nil
    begin
      turn_number += 1
      if human.take_turn(turn_number, computer.board) == :victory
        winner = "Human"
      elsif computer.take_turn(turn_number, human.board) == :victory
        winner = "Brainiac"
      end
    end until winner != nil
    print "#{winner} is victorious!!!\n"
  end

  def instructions
    puts "\nShip Placement".green.bold
    puts " The first stage of the game is ship placement. Each player will\n take turns to place their fleet. You will be prompted to enter\n the coordinates for the prow and stern for each ship.\n Coordinates consist of a letter from A to J and a number from\n 1 to 10. (e.g.: B4 B6 )"
    puts "\nShot Sequence".green.bold
    puts " The second stage of the game is firing shots at the enemy's fleet.\n Players will take turns by entering coordinates in the format\n described above. Once again, you will be prompted each time your\n turn is up. The player who sinks all of the enemy's ships first\n wins the game."
  end

  def computer_placed_ships_msg
    puts "\n\nI have laid out my ships on the grid.\nYou now need to layout your ships.\nThe grid has A1 at the top left and J10 at the bottom right.\n"
  end

end

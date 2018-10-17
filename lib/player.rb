require './lib/board'
require './lib/display'

class Player
    attr_reader :name,
                :board,
                :player_type

  def initialize(name, board, player_type)
    @name = name
    @board = board
    @player_type = player_type
  end

  def correct_placement(ship)
    validated = false
    while validated =+ false
      puts "Enter prow coordinates for #{ship.name}"
      prow = get_coordinates
      puts "Enter stern coordinates for #{ship.name}"
      stern = get_coordinates
      case @board.place_ship(ship, prow, stern)
      when nil
        validated = true
        break
      when :orientation_error
        puts "ERROR: You're trying to place your #{ship.name} in a diagonal orientation."
        puts "It must be placed in horizontal or vertical position. Please try again!"
      when :length_error
        puts "ERROR: The distance between your coordinates for prow and stern doesn't match your #{ship.name}'s length."
        puts "Make sure you enter coordinates that are #{ship.size} apart"
      when :overlap_error
        puts "You're trying to place your #{ship.name} on top of a ship that has been previously placed on the board"
        puts "Please check your board ship placement and try again."
        # display.show_ship_placement(board)
      end
    end
  end

  def place_fleet
    @board.ship_array.each do |ship|
      puts "Let's place your #{ship.name}. This ship is #{ship.size} cells long"
      correct_placement(ship)
    end
    puts "Success! You've placed your fleet on your board"
  end

  def fire_shot(enemy_board)
    puts "Enter coordinates for your shot"
    enemy_board.register_shot(get_coordinates)
  end

  def get_coordinates
    validated = false
    while validated == false
      coordinates = gets.chomp
      if ("A".."J").include?(coordinates[0].upcase) && (1..10).include?(coordinates[1].to_i)
        validated = true
      else
        puts "Invalid input, please enter a letter from A to J and a number from 1 to 10. e.g.: 'B3'"
      end
    end
    coordinates
  end



end

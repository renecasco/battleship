require './lib/board'
require './lib/display'
require './lib/brainiac'

class Player
    attr_reader :name,
                :board,
                :player_type

  def initialize(name, player_type)
    @name = name
    @board = Board.new
    @player_type = player_type
    @display = Display.new
    @brainiac = Brainiac.new
  end

  def correct_placement(ship)
    validated = false
    while validated == false
      print "Enter prow coordinates for #{ship.name}: "
      prow = get_coordinates
      print "Enter stern coordinates for #{ship.name}: "
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
    if @player_type == :ai
      @brainiac.autoplace_all_ships(@board)
    else
      @board.ship_array.each do |ship|
        @display.show_ship_placement(@board)
        puts "\nLet's place your #{ship.name}. This ship is #{ship.size} cells long"
        correct_placement(ship)
      end
      puts "\nSuccess! You've placed your fleet on your board\n"
    end
  end

  def take_turn(turn_number, enemy_board)
    if @player_type == :ai
      shot = @brainiac.intelliguess(enemy_board) #guess is a cell name, ie J4
    else
      print "Enter coordinates for your shot: "
      shot = get_coordinates
    end
    result = enemy_board.register_shot(shot)
    if @player_type == :human
      @display.show_console(@board, enemy_board)
    end
    print "#{@name}, Turn #{turn_number}. Shot: #{shot}.  "
    if result == "X"
      print "HIT!\n"
      ship_name = enemy_board.sunk_ship_name?(shot)
      if ship_name != nil
        print "#{@name} sunk a " + ship_name + "!   "
        if enemy_board.defeated?
          return :victory
        end
      end
    else
      print "Miss.\n"
    end
    :continue
  end

  def get_coordinates
    validated = false
    while validated == false
      coordinates = gets.chomp.upcase
      if ("A".."J").include?(coordinates[0].upcase) && (1..10).include?(coordinates[1].to_i)
        validated = true
      else
        puts "Invalid input, please enter a letter from A to J and a number from 1 to 10. e.g.: 'B3'"
      end
    end
    coordinates
  end



end

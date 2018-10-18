require './lib/board'
require './lib/display'
require './lib/brainiac'
require 'pry'

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
      print "Enter prow and stern coordinates for #{ship.name}: "
      input = get_coordinates_ship
      if input == nil
        @brainiac.autoplace_ship(@board, @board.ship_array.find_index(ship))
        return
      end
      prow = input[0]
      stern = input[1]
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
        correct_placement(ship, )
      end
      @display.show_ship_placement(@board)
      puts "\nSuccess! You've placed your fleet on your board\n"
    end
  end

  def take_turn(turn_number, enemy_board)
    if @player_type == :ai
      shot = @brainiac.intelliguess(enemy_board) #guess is a cell name, ie J4
    else
      @display.show_console(@board, enemy_board)
      print "Enter coordinates for your shot: "
      shot = get_coordinates
      shot = @brainiac.intelliguess(enemy_board) if shot == nil
    end
    result = enemy_board.register_shot(shot)
    print "#{@name}, Turn #{turn_number}. Shot: #{shot}.  "
    if result == "X"
      print "HIT!\n"
      ship_name = enemy_board.sunk_ship_name?(shot)
      if ship_name != nil
        print "#{@name} sunk a " + ship_name + "!   "
        if enemy_board.defeated?
          if @player_type == :human
            @display.show_console(@board, enemy_board)
          else
            @display.show_console(enemy_board, @board)
          end
          return :victory
        end
      end
    else
      print "Miss.\n"
    end
    :continue
  end

  def get_coordinates_ship
    validated = true
    begin
      coordinates = gets.chomp.upcase
      return nil if coordinates == ""
      coordinates = coordinates.split
      if coordinates.length != 2
        validated = false
      else
        coordinates.each do |coordinate|
          if !(("A".."J").include?(coordinate[0])) || !((1..10).include?(coordinate[1..-1].to_i))
            validated = false
          end
        end
      end
      if validated == false
        puts "Invalid input, please enter prow and stern coordinates (e.g.: B3 D3)"
      end
    end until validated == true
    coordinates
  end

  def get_coordinates
    validated = false
    while validated == false
      coordinate = gets.chomp.upcase
      return nil if coordinate == ""
      if ("A".."J").include?(coordinate[0]) && (1..10).include?(coordinate[1..-1].to_i)
          validated = true
      else
        puts "Invalid input, please enter a letter from A to J and a number from 1 to 10. e.g.: 'B3'"
      end
    end
    coordinate
  end

end

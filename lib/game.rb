dir = File.dirname(__FILE__)
require "#{dir}/board"

class Game
  attr_reader :first_name, :second_name, :first_board, :second_board

  def start
    setup_boards
    loop do
      puts "#{first_name}'s Board:"
      puts first_board
      puts
      puts "#{second_name}'s Board:"
      puts second_board

      break unless take_turn(first_name, second_board)
      break unless take_turn(second_name, first_board)
    end


  end

  private

  def take_turn(name, other_board)
    coords = prompt_to_hit(name)
    board.attack(coords)
    board.ships_left?
  end

  def prompt_to_hit(name)
    puts "#{name}'s Turn"
    puts "Enter x coord to hit: "
    x_coord = gets.chomp
    puts "Enter y coord to hit: "
    y_coord = gets.chomp
    [y_coord, x_coord]
  end

  def setup_boards
    @first_name, @first_board = setup_board
    @second_name, @second_board = setup_board


  end

  def setup_board
    puts "Enter your name"
    name = gets.chomp

    begin
      board = Board.new(10, 10).generate(5)
      puts board
      puts
      puts "Do you like your board? (y/N)"
    end while gets.chomp != "y"

    [name, board]
  end


end
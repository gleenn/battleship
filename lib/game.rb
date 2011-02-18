dir = File.dirname(__FILE__)
require "#{dir}/board"

class Game
  def start
      setup_boards
      puts to_s
  end

  private

  def setup_boards
    first_name, first_board = setup_board
    second_name, second_board = setup_board

    
  end

  def setup_board
    puts "Enter your name"
    name = gets.chomp

    begin
      board = Board.new(10,10).generate(5)
      puts board
      puts
      puts "Do you like your board? (y/N)"
    end while gets.chomp != "y"

    [name, board]
  end


end
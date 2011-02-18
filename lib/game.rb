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

    board = Board.new(10,10).generate
    puts board
    puts
    puts "Do you like your board?"

    while gets.chomp != "y"
      board = Board.new(10,10).generate
      puts board
      puts
      puts "Do you like your board?"
    end

    [name, board]
  end
end
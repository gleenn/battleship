dir = File.dirname(__FILE__)
require "#{dir}/ship"

class Board
  attr_reader :height, :width
  attr_accessor :grid, :ships

  def initialize(height, width)
    @height = height
    @width  = width

    @grid   = Array.new(@height) { Array.new(@width) }
    @ships = []

    @grid.each_with_index do |row, y|
      row.each_with_index do |column, x|
        @grid[y][x] = nil
      end
    end
  end

  def to_s
    output = ""
    @grid.each do |row|
      row.each do |column|
        output << (column.nil? ? "#" : column)
      end
      output << "\n"
    end
    output
  end

  def generate(num_ships)
    num_ships.times do
      ship = place_ship
    end

    self
  end

  def place_ship
    begin
      dy          = rand(2)
      dx          = 1 - dy
      start_y     = rand(@height-(dy*Ship::LENGTH))
      start_x     = rand(@width-(dx*Ship::LENGTH))

      ship = Ship.new(start_y..(start_y+(dy*(Ship::LENGTH-1))), start_x..(start_x+(dx*(Ship::LENGTH-1))))
    end while !valid_place_for?(ship)

    ships << ship
    mark_ship(ship)
    ship
  end

  def valid_place_for?(ship)
    ! ships.any? do |ship_on_board|
      ship_on_board.collides_with?(ship)
    end
  end

  def ships_left?
    ! ships.all? &:sunk?
  end

  def attack!(y, x)
    made_hit = false
    ships.each do |ship|
      if ship.hit?(y,x)
        ship.hit!(y,x)
        mark_hit(y, x)
        made_hit = true
      end
    end
    mark_miss(y, x) unless made_hit
    made_hit
  end

  def mark_miss(y, x)
    grid[y][x] = "M"
  end

  def mark_hit(y, x)
    grid[y][x] = "H"
  end

  def mark_ship(ship)
    ship.x_range.each do |x|
      ship.y_range.each do |y|
        grid[y][x] = "*"
      end
    end
  end
end
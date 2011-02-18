require 'set'

class Ship
  LENGTH = 5

  attr_reader :x_range, :y_range, :hits

  def initialize(x_range, y_range)
    @x_range = x_range
    @y_range = y_range
    raise "Ship not length 5" if [(x_range.end - x_range.first + 1), (y_range.end - y_range.first + 1)].max != Ship::LENGTH

    @hits = Set.new
  end

  def collides_with?(ship)
    ship.y_range.each do |y|
      ship.x_range.each do |x|
        return true if hit?(y,x)
      end
    end
    false
  end

 def hit?(y, x)
   x_range.include?(x) && y_range.include?(y)
 end

  def hit!(y, x)
    hits << [y,x]
  end

  def sunk?
    hits.length == Ship::LENGTH
  end
end
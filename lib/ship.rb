class Ship
  LENGTH = 5

  attr_reader :x_range, :y_range

  def initialize(x_range, y_range)
    @x_range = x_range
    @y_range = y_range
  end

  def collides_with?(ship)
    x_range.each do |x|
      y_range.each do |y|
        return true if ship.x_range.include?(x) && ship.y_range.include?(y)
      end
    end
    false
  end
end
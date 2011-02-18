class Board
  attr_reader :grid, :height, :width

  def initialize(height, width)
    @height = height
    @width = width

    @grid = Array.new(@height){Array.new(@width)}

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
        output << (column.nil? ? "#" : "*")
      end
      output << "\n"
    end
    output
  end

  def generate(rng=Kernel)
    dy = rand(2)
    dx = 1 - dy

    ship_length = 5
    start_y = rng.rand(@height-(dy*ship_length))
    start_x = rng.rand(@width-(dx*ship_length))

    5.times do |i|
      @grid[start_y+(i*dy)][start_x+(i*dx)] = "*"
    end

    self
  end
end
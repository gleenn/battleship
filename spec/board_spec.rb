dir = File.dirname(__FILE__)
require "#{dir}/../lib/board"
require "#{dir}/../lib/ship"
require "#{dir}/../spec/spec_helper"

describe Board do
  attr_reader :board

  before do
    @board = Board.new(10, 10)
  end

  it "can be displayed" do
    board.to_s.should == ("#"*10+"\n")*10
  end

  describe "#initialize" do
    it "works" do
      board.width.should == 10
      board.height.should == 10
    end
  end

  describe "#place_ship" do
    it "places a new ship in an empty spot on the board" do
      @board.place_ship

      ship_spots = 0
      @board.grid.each do |row|
        row.each do |e|
          ship_spots += 1 unless e.nil?
        end
      end
      ship_spots.should == Ship::LENGTH
    end

    it "adds the ship to its list of ships" do
      @board.place_ship
      @board.ships.length.should == 1
      @board.place_ship
      @board.ships.length.should == 2
    end
  end

  describe "#generate(x)" do
    it "can place 1 ships on the board" do
      (0..3).each do |num_ships|
        board = Board.new(10, 10)
        board = board.generate(num_ships)

        board.ships.length.should == num_ships

        ship_spots = 0
        board.grid.each do |row|
          row.each do |e|
            ship_spots += 1 unless e.nil?
          end
        end
        ship_spots.should == num_ships*Ship::LENGTH
      end
    end
  end

  describe "#valid_place_for(ship)" do
    it "returns true if the ship doesn't collide with anything" do
      ship = Ship.new(0..0, 1..5)
      @board.should be_valid_place_for(ship)
    end

    it "returns false if the ship doesn't collide with anything" do
      ship = Ship.new(0..0, 1..5)
      @board.ships << ship

      other_ship = Ship.new(0..0, 2..6)
      @board.should_not be_valid_place_for(ship)
    end
  end

  describe "#ships_left?" do
    describe "when it should return false" do
      it "doesn't have any ships" do
        @board.should_not be_ships_left
      end

      it "has only sunk ships" do
        ship = @board.place_ship
        ship.y_range.each do |y|
          ship.x_range.each do |x|
            ship.hit!(y, x)
          end
        end
      end
    end

    describe "when it should return true" do
      it "has a ship that hasn't been sunk yet" do
        @board.place_ship
        @board.should be_ships_left
      end
    end
  end
end
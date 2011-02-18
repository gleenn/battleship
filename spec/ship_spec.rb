dir = File.dirname(__FILE__)
require "#{dir}/../spec/spec_helper"
require "#{dir}/../lib/board.rb"
require "#{dir}/../lib/ship.rb"

describe Ship do
  before do
    @board = Board.new(10, 10)
    @ship  = Ship.new(0..0, 1..5)
  end

  describe "#initialize" do
    it "complains if you make a ship longer than Ship::LENGTH" do
      expect do
        Ship.new(0..0,0..10)
      end.should raise_error
    end
  end

  describe "#collides_with(ship)" do
    it "returns true if it collides with itself" do
      @ship.should be_collides_with(@ship)

    end

    it "returns true if the tips touch, same direction" do
      @ship.should be_collides_with(Ship.new(0..0, 5..9))
    end

    it "returns false if they don't overlap" do
      @ship.should_not be_collides_with(Ship.new(0..0, 6..10))
      @ship.should_not be_collides_with(Ship.new(1..1, 1..5))
    end

    it "returns true if the ships overlap orthogonally" do
      Ship.new(0..4, 1..1).should be_collides_with(Ship.new(1..1, 0..4))
    end
  end

  describe "#hit!" do
    it "adds the hit spot to its list of hits" do
      @ship.hit!(0,3)
      @ship.hits.should be_include([0,3])
    end
  end

  describe "#sunk?" do
    before do
      @ship = Ship.new(0..0, 1..5)
    end

    it "returns false on a new ship" do
      ship = @board.place_ship
      ship.should_not be_sunk
    end

    it "returns false on a partially hit ship" do
      ship = @board.place_ship
      ship.hit!(0,1)
      ship.should_not be_sunk
    end

    it "returns true on a totally hit ship" do
      ship = @board.place_ship
      ship.hit!(0,1)
      ship.hit!(0,2)
      ship.hit!(0,3)
      ship.hit!(0,4)
      ship.hit!(0,5)
      ship.should be_sunk
    end
  end
end

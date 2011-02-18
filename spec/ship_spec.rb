dir = File.dirname(__FILE__)
require "#{dir}/../spec/spec_helper"
require "#{dir}/../lib/board.rb"
require "#{dir}/../lib/ship.rb"

describe Ship do
  before do
    @board = Board.new(10, 10)
    @ship  = Ship.new(0..0, 1..6)
  end

  describe "#collides_with(ship)" do
    it "returns true if it collides with itself" do
      @ship.should be_collides_with(@ship)

    end

    it "returns true if the tips touch, same direction" do
      @ship.should be_collides_with(Ship.new(0..0, 6..10))
    end

    it "returns false if they don't overlap" do
      @ship.should_not be_collides_with(Ship.new(0..0, 7..10))
      @ship.should_not be_collides_with(Ship.new(1..1, 1..6))
    end

    it "returns true if the ships overlap orthogonally" do
      Ship.new(0..4, 1..1).should be_collides_with(Ship.new(1..1, 0..4))
    end
  end
end

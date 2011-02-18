dir = File.dirname(__FILE__)
require "#{dir}/../lib/board"
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

  describe "#generate" do
    it "works" do
      board = @board.generate(Kernel)
      board.grid.any? { |row| row.any? { |e| !e.nil? } }.should be
      ship_spots = 0
      board.grid.each do |row|
        row.each do |e|
          ship_spots += 1 unless e.nil?
        end
      end
      ship_spots.should == 5
    end
  end

end
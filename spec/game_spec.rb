dir = File.dirname(__FILE__)
require "#{dir}/../spec/spec_helper"
require "#{dir}/../lib/game.rb"

describe Game do
  before do
    @game = Game.new
  end

  describe "#start" do
    it "works" do
#      @game.start
    end
  end

  def stub_everything
  end

end
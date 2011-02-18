#!/usr/bin/env ruby

dir = File.dirname(__FILE__)
require "#{dir}/lib/game"
require "#{dir}/lib/board"


game = Game.new

game.start
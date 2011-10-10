#! /usr/bin/env ruby

$LOAD_PATH << File.expand_path(File.dirname(__FILE__))

require 'game'

if ARGV.size < 2 
  puts "Usage: ruby game.rb player1 player2 ..."
  exit 1
end
game = Game.new( *ARGV )
game.play

$LOAD_PATH << File.expand_path(File.dirname(__FILE__))
require 'player'
require 'round'

class Game
  
  TOTAL_NUMBER_OF_DICE = 5

  attr_reader :players

  def initialize( *players )
    @players = players.map { |player| Player.new( player ) }
    @players = @players.uniq
  end
  
  def play
    begin
      Round.new( self ).play
    end while players.none?(&:in_win_zone?)
    LastRound.new( self ).play
  end
  
end

if $0 == __FILE__
  # game = Game.new( 'Susan', 'John', 'Mary')
  game = Game.new( *ARGV )
  game.play
end
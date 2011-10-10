$LOAD_PATH << File.expand_path(File.dirname(__FILE__))
require 'player'
require 'round'

class Game
  
  attr_accessor :input_stream, :output_stream
  
  TOTAL_NUMBER_OF_DICE = 5

  attr_reader :players

  def initialize( *players )
    @players = players.map { |player| Player.new( player ) }
    @players = @players.uniq
    @input_stream = STDIN
    @output_stream = STDOUT
  end
  
  def play
    begin
      Round.new( self ).play
    end while players.none?(&:in_win_zone?)
    LastRound.new( self ).play
  end
  
end


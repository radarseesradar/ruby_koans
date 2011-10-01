require 'player'

class Game
  
  TOTAL_NUMBER_OF_DICE = 5

  attr_reader :players

  def initialize( *players )
    @players = players.map { |player| Player.new( player ) }
    @players = @players.uniq
  end

end
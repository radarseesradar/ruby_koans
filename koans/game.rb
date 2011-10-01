require 'player'

class Game
  attr_reader :players
  def initialize( *players )
    @players = players.map { |player| Player.new( player ) }
  end
end
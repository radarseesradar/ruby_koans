class Round

  attr_reader :game

  def initialize( game )
    @game = game
  end
  
  def last_round_message
    ''
  end

end

class LastRound < Round
  
  def last_round_message
    'This is the last round.'
  end
end
class Round

  attr_reader :game

  def initialize( game )
    @game = game
  end
  
  def last_round_message
    ''
  end
  
  def mark_current_score( score_as_string )
    '*' + score_as_string
  end
  
  # hook for LastRound
  def score_as_string( player )
    player.game_accumulator.value.to_s
  end  
    
  def scores( current_player )
    game.players.map do | player |
      score_as_string = self.score_as_string( player )
      player == current_player ? mark_current_score( score_as_string) : score_as_string
    end
  end
  
  def game_status_message( current_player )
    scores = self.scores( current_player )
    last_score = scores[-1]
    first_scores = scores[0...-1].join(', ')
    first_scores << ',' if scores.size >= 3
    "#{current_player.name}, the game scores are #{first_scores} and #{last_score}."
  end

end

class LastRound < Round
  
  attr_reader :first_player_in_win_zone, :players
  
  def initialize( game )
    super
    @first_player_in_win_zone = game.players.find( &:in_win_zone? )
    return unless @first_player_in_win_zone
    after = game.players.last( game.players.size - 1 - game.players.index( @first_player_in_win_zone ) )
    before = game.players.first( game.players.index( @first_player_in_win_zone ) )
    @players = after + before
  end
  
  def score_as_string( player )
    score = super
    score = '(' + score + ')' if player == first_player_in_win_zone
    score
  end
    
  def last_round_message
    'This is the last round.'
  end

end

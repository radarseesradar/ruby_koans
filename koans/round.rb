$LOAD_PATH << File.expand_path(File.dirname(__FILE__))
require 'turn'
class Round

  attr_reader :game

  def initialize( game )
    @game = game
  end
  
  def play_common( player )
    Kernel.puts
    Kernel.puts
    Kernel.puts game_status_message( player )
    Kernel.puts last_round_message
    Kernel.puts
    current_turn = Turn.new( game, player )
    current_turn.play
  end
  
  def play
    game.players.each do | player |
      play_common( player )
      break if player.in_win_zone?
    end
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
    players = game.players
    @players = players.rotate( players.index(@first_player_in_win_zone) ).drop(1)
  end
  
  def play
    players.each do | player |
      play_common( player )
    end
    Kernel.puts
    Kernel.puts final_scores_message
    Kernel.puts winner_message
  end

  def score_as_string( player )
    score = super
    score = '(' + score + ')' if player == first_player_in_win_zone
    score
  end
    
  def last_round_message
    'This is the last round.'
  end
  
  def winners
    first_max = game.players.max_by { | p | p.game_accumulator.value }
    game.players.find_all { | p | p.game_accumulator.value == first_max.game_accumulator.value }
  end
  
  def final_scores_message
    scores = game.players.map { | p | p.game_accumulator.value.to_s }
    "Final scores are #{scores[0...-1].join(', ')} and #{scores[-1]}."
  end
  
  def winner_message
    winners = self.winners
    if winners.size == 1
      "#{winners.first.name} is the winner."
    elsif winners.size > 1
      "#{winners[0...-1].map(&:name).join(', ')} and #{winners[-1].name} are winners."
    else
      ''
    end
  end
    

end

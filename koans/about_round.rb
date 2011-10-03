require File.expand_path(File.dirname(__FILE__) + '/edgecase')

require 'round'

class AboutRound < EdgeCase::Koan

  def test_round_should_have_a_game
    game = Game.new( 'John', 'Mary')
    round = Round.new( game )
    assert_equal game,round.game
  end
  
  def test_last_round_message
    game = Game.new( 'John', 'Mary')
    round = Round.new( game )
    assert_equal '', round.last_round_message
  end
  
  def test_scores
    game = Game.new( 'John', 'Mary')
    john = game.players.first
    john.turn_accumulator.update( 300 )
    john.game_accumulator.update( john.turn_accumulator )
    mary = game.players.last
    mary.turn_accumulator.update( 400 )
    mary.game_accumulator.update( mary.turn_accumulator )
    round = Round.new( game )
    assert_equal ['*300', '400'], round.scores( john )
  end
  
  def test_game_status_message_for_2_players
    game = Game.new( 'John', 'Mary')
    john = game.players.first
    john.turn_accumulator.update( 300 )
    john.game_accumulator.update( john.turn_accumulator )
    mary = game.players.last
    mary.turn_accumulator.update( 400 )
    mary.game_accumulator.update( mary.turn_accumulator )
    round = Round.new( game )
    assert_equal 'John, the game scores are *300 and 400.', round.game_status_message( john )
  end

  def test_game_status_message_for_3_players
    game = Game.new( 'John', 'Mary', 'Elizabeth')
    john = game.players.first
    john.turn_accumulator.update( 300 )
    john.game_accumulator.update( john.turn_accumulator )
    mary = game.players[1]
    mary.turn_accumulator.update( 400 )
    mary.game_accumulator.update( mary.turn_accumulator )
    elizabeth = game.players.last
    elizabeth.turn_accumulator.update( 350 )
    elizabeth.game_accumulator.update( elizabeth.turn_accumulator )
    round = Round.new( game )
    assert_equal 'Mary, the game scores are 300, *400, and 350.', round.game_status_message( mary )
  end
end

class AboutLastRound < EdgeCase::Koan

  def test_last_round_message
    game = Game.new( 'John', 'Mary')
    last_round = LastRound.new( game )
    assert_equal 'This is the last round.', last_round.last_round_message
  end
  
  def test_first_player_in_win_zone
    game = Game.new( 'John', 'Mary', 'Elizabeth')
    john = game.players.first
    john.turn_accumulator.update( 300 )
    john.game_accumulator.update( john.turn_accumulator )
    mary = game.players[1]
    mary.turn_accumulator.update( 3000 )
    mary.game_accumulator.update( mary.turn_accumulator )
    elizabeth = game.players.last
    elizabeth.turn_accumulator.update( 350 )
    elizabeth.game_accumulator.update( elizabeth.turn_accumulator )
    round = LastRound.new( game )
    assert_equal mary,round.first_player_in_win_zone
  end

  def test_players
    game = Game.new( 'John', 'Mary', 'Elizabeth')
    john = game.players.first
    john.turn_accumulator.update( 300 )
    john.game_accumulator.update( john.turn_accumulator )
    mary = game.players[1]
    mary.turn_accumulator.update( 3000 )
    mary.game_accumulator.update( mary.turn_accumulator )
    elizabeth = game.players.last
    elizabeth.turn_accumulator.update( 350 )
    elizabeth.game_accumulator.update( elizabeth.turn_accumulator )
    round = LastRound.new( game )
    assert_equal  [elizabeth, john], round.players
  end
  
  def test_score_as_string
    game = Game.new( 'John', 'Mary', 'Elizabeth')
    john = game.players.first
    john.turn_accumulator.update( 300 )
    john.game_accumulator.update( john.turn_accumulator )
    mary = game.players[1]
    mary.turn_accumulator.update( 3000 )
    mary.game_accumulator.update( mary.turn_accumulator )
    elizabeth = game.players.last
    elizabeth.turn_accumulator.update( 350 )
    elizabeth.game_accumulator.update( elizabeth.turn_accumulator )
    round = LastRound.new( game )
    assert_equal '(3000)', round.score_as_string( mary )
    assert_equal '350', round.score_as_string( elizabeth )
  end

  def test_game_status_message_for_2_players
    game = Game.new( 'John', 'Mary')
    john = game.players.first
    john.turn_accumulator.update( 300 )
    john.game_accumulator.update( john.turn_accumulator )
    mary = game.players.last
    mary.turn_accumulator.update( 4000 )
    mary.game_accumulator.update( mary.turn_accumulator )
    round = LastRound.new( game )
    assert_equal 'John, the game scores are *300 and (4000).', round.game_status_message( john )
  end

  def test_game_status_message_for_3_players
    game = Game.new( 'John', 'Mary', 'Elizabeth')
    john = game.players.first
    john.turn_accumulator.update( 3000 )
    john.game_accumulator.update( john.turn_accumulator )
    mary = game.players[1]
    mary.turn_accumulator.update( 400 )
    mary.game_accumulator.update( mary.turn_accumulator )
    elizabeth = game.players.last
    elizabeth.turn_accumulator.update( 350 )
    elizabeth.game_accumulator.update( elizabeth.turn_accumulator )
    round = LastRound.new( game )
    assert_equal 'Mary, the game scores are (3000), *400, and 350.', round.game_status_message( mary )
  end
  
  def test_winners
    game = Game.new( 'John', 'Mary', 'Elizabeth')
    john = game.players.first
    john.turn_accumulator.update( 3500 )
    john.game_accumulator.update( john.turn_accumulator )
    mary = game.players[1]
    mary.turn_accumulator.update( 3500 )
    mary.game_accumulator.update( mary.turn_accumulator )
    elizabeth = game.players.last
    elizabeth.turn_accumulator.update( 350 )
    elizabeth.game_accumulator.update( elizabeth.turn_accumulator )
    round = LastRound.new( game )
    assert_equal [john,mary], round.winners
  end
  

end
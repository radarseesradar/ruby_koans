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

end

class AboutLastRound < EdgeCase::Koan

  def test_last_round_message
    game = Game.new( 'John', 'Mary')
    last_round = LastRound.new( game )
    assert_equal 'This is the last round.', last_round.last_round_message
  end

end
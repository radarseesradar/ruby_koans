require File.expand_path(File.dirname(__FILE__) + '/edgecase')

require 'turn'

class AboutTurn < EdgeCase::Koan
  def test_turn_should_have_a_player
    current_player = Player.new( 'Mary' )
    current_turn = Turn.new( current_player )
    assert_equal 'Mary',current_turn.player.name
  end
end

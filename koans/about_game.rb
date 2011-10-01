require File.expand_path(File.dirname(__FILE__) + '/edgecase')

require 'game'

class AboutGame < EdgeCase::Koan

  def test_should_have_orderd_list_of_players
    mary = Player.new( 'Mary')
    john = Player.new( 'John')
    players = [mary, john]
    game = Game.new( 'Mary', 'John' )
    assert_equal game.players, players
  end
  
  def test_should_not_have_duplicate_players
    mary = Player.new( 'Mary')
    john = Player.new( 'John')
    players = [mary, john]
    game = Game.new( 'Mary', 'John', 'John' )
    assert_equal game.players, players
  end
  
  def test_total_number_of_dice_should_equal_5
    assert_equal 5,Game::TOTAL_NUMBER_OF_DICE
  end

end

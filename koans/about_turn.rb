require File.expand_path(File.dirname(__FILE__) + '/edgecase')

require 'turn'

class AboutTurn < EdgeCase::Koan

  def test_turn_should_have_a_game_and_a_player
    current_game = Game.new( 'John', 'Mary' )
    current_player = current_game.players.first
    current_turn = Turn.new( current_game, current_player )
    assert_equal true, current_turn.game.is_a?( Game )
    assert_equal 'John',current_turn.player.name
  end
  
  def test_turn_should_have_5_dice_available
    current_game = Game.new( 'John', 'Mary' )
    current_player = current_game.players.first
    current_turn = Turn.new( current_game, current_player )
    assert_equal Game::TOTAL_NUMBER_OF_DICE,current_turn.number_of_dice_available
  end
  
  def test_roll_randomly
    current_game = Game.new( 'John', 'Mary' )
    current_player = current_game.players.first
    current_turn = Turn.new( current_game, current_player )
    roll = current_turn.roll_randomly( 3 )
    assert_equal 3,roll.size
  end
  
  def test_roll
    current_game = Game.new( 'John', 'Mary' )
    current_player = current_game.players.first
    current_turn = Turn.new( current_game, current_player )
    current_turn.roll
    assert_equal 5,current_turn.last_roll_array.size
  end
  
  
  def test_roll_status_message
    roll_status_message = <<STATUS_MESSAGE
You just rolled [1, 2, 4, 6, 3], and you have accumulated 100 points in this turn.
Do you wish to roll your 4 remaining dice (yes/[no]) ? 
STATUS_MESSAGE
    current_game = Game.new( 'John', 'Mary' )
    current_player = current_game.players.first
    current_turn = Turn.new( current_game, current_player )
    current_turn.roll( [1, 2, 4, 6, 3] )
    assert_equal roll_status_message.chomp, current_turn.roll_status_message
  end

  def test_turn_should_begin_with_turn_accumulator_at_0
    roll_status_message = <<STATUS_MESSAGE
You just rolled [1, 2, 4, 6, 3], and you have accumulated 100 points in this turn.
Do you wish to roll your 4 remaining dice (yes/[no]) ? 
STATUS_MESSAGE
    current_game = Game.new( 'John', 'Mary' )
    current_player = current_game.players.first
    current_turn = Turn.new( current_game, current_player )
    current_turn.roll( [1, 2, 4, 6, 3] )
    next_turn = Turn.new( current_game, current_player )
    next_turn.roll( [1, 2, 4, 6, 3])
    assert_equal roll_status_message.chomp, next_turn.roll_status_message
  end
  
  def test_values_of_rolls_within_turn_should_accumulate
    roll_status_message = <<STATUS_MESSAGE
You just rolled [1, 2, 4, 6, 3], and you have accumulated 200 points in this turn.
Do you wish to roll your 4 remaining dice (yes/[no]) ? 
STATUS_MESSAGE
    current_game = Game.new( 'John', 'Mary' )
    current_player = current_game.players.first
    current_turn = Turn.new( current_game, current_player )
    current_turn.roll( [1, 2, 4, 6, 3] )
    current_turn.roll( [1, 2, 4, 6, 3] )
    assert_equal roll_status_message.chomp, current_turn.roll_status_message
  end

end

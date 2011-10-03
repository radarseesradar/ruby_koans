require File.expand_path(File.dirname(__FILE__) + '/edgecase')

require 'accumulator'

class AboutAccumulator < EdgeCase::Koan
  def test_new_accumulator_should_have_a_value_of_0
    assert_equal 0,Accumulator.new.value
  end  
end

class AboutTurnAccumulator < EdgeCase::Koan
  
  def test_turn_accumulator_contributable_floor_should_be_300
    assert_equal 300, TurnAccumulator::CONTRIBUTABLE_FLOOR
  end

  def test_turn_accumulator_should_be_updateable
    accumulator = TurnAccumulator.new
    accumulator.update( 150 )
    assert_equal 150, accumulator.value
    accumulator.update( 50 )
    assert_equal 200, accumulator.value
  end
  
  def test_turn_accumulator_should_clear_itself_when_updated_by_0
    accumulator = TurnAccumulator.new
    accumulator.update( 150 )
    assert_equal 150, accumulator.value
    accumulator.update( 0 )
    assert_equal 0, accumulator.value
  end

  def test_turn_accumulator_should_be_explicityly_clearable
    accumulator = TurnAccumulator.new
    accumulator.update( 150 )
    assert_equal 150, accumulator.value
    accumulator.clear
    assert_equal 0, accumulator.value
  end
  
  def test_turn_accumulator_should_not_be_contributable
    accumulator = TurnAccumulator.new
    accumulator.update( 250 )
    assert_equal 250, accumulator.value
    accumulator.check_contributable
    assert_equal false, accumulator.contributable?
  end

  def test_turn_accumulator_should_be_contributable
    accumulator = TurnAccumulator.new
    accumulator.update( TurnAccumulator::CONTRIBUTABLE_FLOOR )
    assert_equal TurnAccumulator::CONTRIBUTABLE_FLOOR, accumulator.value
    accumulator.check_contributable
    assert_equal true, accumulator.contributable?
  end

  def test_turn_accumulator_should_remain_contributable
    accumulator = TurnAccumulator.new
    accumulator.update( TurnAccumulator::CONTRIBUTABLE_FLOOR + 50)
    assert_equal TurnAccumulator::CONTRIBUTABLE_FLOOR + 50, accumulator.value
    accumulator.check_contributable
    assert_equal true, accumulator.contributable?
    accumulator.clear
    accumulator.update( 50 )
    accumulator.check_contributable
    assert_equal true, accumulator.contributable?
  end

end

class AboutGameAccumulator < EdgeCase::Koan
  
  def test_game_accumulator_win_zone_floor_should_be_3000
    assert_equal 3000, GameAccumulator::WIN_ZONE_FLOOR 
  end

  def test_update_should_set_arg_to_contributable
    turn_accumulator = TurnAccumulator.new
    turn_accumulator.update( TurnAccumulator::CONTRIBUTABLE_FLOOR )
    assert_equal false, turn_accumulator.contributable?
    game_accumulator = GameAccumulator.new
    game_accumulator.update( turn_accumulator)
    assert_equal true, turn_accumulator.contributable?
  end

  def test_update_should_clear_args_value
    turn_accumulator = TurnAccumulator.new
    turn_accumulator.update( 50 )
    game_accumulator = GameAccumulator.new
    game_accumulator.update( turn_accumulator)
    assert_equal 0,turn_accumulator.value
  end
  
  def test_game_accumulator_should_update_its_value_if_arg_is_contributable
      turn_accumulator = TurnAccumulator.new
      turn_accumulator.update( TurnAccumulator::CONTRIBUTABLE_FLOOR )
      game_accumulator = GameAccumulator.new
      game_accumulator.update( turn_accumulator)
      assert_equal TurnAccumulator::CONTRIBUTABLE_FLOOR,game_accumulator.value
  end


  def test_game_accumulator_should_not_update_its_value_if_arg_is_not_contributable
    turn_accumulator = TurnAccumulator.new
    turn_accumulator.update( 50 )
    game_accumulator = GameAccumulator.new
    game_accumulator.update( turn_accumulator)
    assert_equal 0,game_accumulator.value
  end
    
  
  def test_should_be_in_win_zone
    turn_accumulator = TurnAccumulator.new
    turn_accumulator.update( GameAccumulator::WIN_ZONE_FLOOR )
    game_accumulator = GameAccumulator.new
    game_accumulator.update( turn_accumulator )
    assert_equal true, game_accumulator.in_win_zone?
    turn_accumulator.update( 50 )
    assert_equal true, game_accumulator.in_win_zone?
  end
  
  def test_should_not_be_in_win_zone
    turn_accumulator = TurnAccumulator.new
    turn_accumulator.update( 50 )
    game_accumulator = GameAccumulator.new
    game_accumulator.update( turn_accumulator )
    assert_equal false, game_accumulator.in_win_zone?
  end
  
end


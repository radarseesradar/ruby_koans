require File.expand_path(File.dirname(__FILE__) + '/edgecase')

require 'accumulator'

class AboutAccumulator < EdgeCase::Koan
  def test_new_accumulator_should_have_a_value_of_0
    assert_equal 0,Accumulator.new.value
  end  
end

class AboutTurnAccumulator < EdgeCase::Koan

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

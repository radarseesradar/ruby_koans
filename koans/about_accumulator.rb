require File.expand_path(File.dirname(__FILE__) + '/edgecase')

require 'accumulator'

class AboutAccumulator < EdgeCase::Koan
  def test_new_accumulator_should_have_a_value_of_0
    assert_equal 0,Accumulator.new.value
  end
end

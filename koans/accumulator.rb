class Accumulator
  attr_reader :value
  
  def initialize
    @value = 0
  end

end

class TurnAccumulator < Accumulator
  CONTRIBUTABLE_FLOOR = 300
  def initialize
    super
    @contributable = false
  end
  
  def contributable?
    @contributable
  end
  
  def update( score )
    if score == 0
      @value = 0
    else
      @value += score
    end
  end
  
  def clear
    @value = 0
  end
  
  def check_contributable
    if !contributable? && @value >= CONTRIBUTABLE_FLOOR
      @contributable = true
    end
  end

end
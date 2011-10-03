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

class GameAccumulator < Accumulator

  WIN_ZONE_FLOOR = 3000
  
  def update( turn_accumulator )
    turn_accumulator.check_contributable
    @value += turn_accumulator.value if turn_accumulator.contributable?
    turn_accumulator.clear
    @in_win_zone = @value >= WIN_ZONE_FLOOR
  end
  
  def in_win_zone?
    @in_win_zone
  end

end


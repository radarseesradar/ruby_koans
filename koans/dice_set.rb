class DiceSet
  MAX_DIE_VALUE = 6
  def roll( number_of_dice )
    @dice = Array.new(number_of_dice) { rand(MAX_DIE_VALUE) + 1}
  end
  def values
    @dice
  end
end

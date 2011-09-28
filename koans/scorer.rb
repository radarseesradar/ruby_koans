class Scorer
  def initialize( dice )
    @dice = dice
  end
  
  def score
    sum = 0
    sum += score_die_value( 1, 100, 1000)
    sum += score_die_value( 5, 50 )
    [2,3,4,6].inject( sum ) { | sum, die_value | sum + score_die_value( die_value ) }
  end
  
  def score_die_value( die_value, singletons_multiplicand=0, triplets_multiplicand=die_value*100 )
    occurrences = @dice.count( die_value )
    triplets = occurrences / 3
    singletons = occurrences % 3
    singletons * singletons_multiplicand + triplets * triplets_multiplicand
  end
  
end


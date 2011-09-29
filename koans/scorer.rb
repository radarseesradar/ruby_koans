class Scorer
  attr_reader :score, :number_of_non_scoring_dice
  
  def initialize( role_result )
    @role_result = role_result
    @number_of_non_scoring_dice = @role_result.size
    @score = compute_score
  end
  
  def compute_score
    sum = 0
    sum += score_die_value( 1, 100, 1000)
    sum += score_die_value( 5, 50 )
    [2,3,4,6].inject( sum ) { | sum, die_value | sum + score_die_value( die_value ) }
  end
  
  def subtract_scoring_dice( triplets, singletons, singletons_multiplicand )
    @number_of_non_scoring_dice -= triplets * 3
    @number_of_non_scoring_dice -= singletons if singletons_multiplicand != 0
  end
  
  def score_die_value( die_value, singletons_multiplicand=0, triplets_multiplicand=die_value*100 )
    occurrences = @role_result.count( die_value )
    triplets = occurrences / 3
    singletons = occurrences % 3
    subtract_scoring_dice( triplets, singletons, singletons_multiplicand )
    singletons * singletons_multiplicand + triplets * triplets_multiplicand
  end
  
  
end


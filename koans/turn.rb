require 'Game'
require 'Player'


class Turn

  attr_reader :player, :game, :number_of_dice_available, :last_roll_array

  def initialize( game, player  )
    @game = game
    @player = player
    @player.turn_accumulator.clear
    @number_of_dice_available = Game::TOTAL_NUMBER_OF_DICE
  end
  
  def roll( dice_set_array = roll_randomly( @number_of_dice_available ) )
    @last_roll_array = dice_set_array
    scorer = Scorer.new( @last_roll_array )
    @player.turn_accumulator.update( scorer.score )
    @number_of_dice_available = scorer.number_of_non_scoring_dice
  end  
  
  def roll_randomly( number_of_dice = @number_of_dice_available )
    dice_set = DiceSet.new
    dice_set.roll( number_of_dice )
    dice_set.values
  end
  
  def roll_status_message
        roll_status_message = <<STATUS_MESSAGE
You just rolled #{@last_roll_array}, and you have accumulated #{@player.turn_accumulator.value} points in this turn.
Do you wish to roll your #{@number_of_dice_available} remaining dice (yes/[no]) ? 
STATUS_MESSAGE
    roll_status_message.chomp
  end
  
end
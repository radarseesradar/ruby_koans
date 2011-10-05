$LOAD_PATH << File.expand_path(File.dirname(__FILE__))
require 'player'
require 'dice_set'
require 'scorer'


class Turn

  attr_reader :player, :game, :number_of_dice_available, :last_roll_values

  def initialize( game, player  )
    @game = game
    @player = player
    @player.turn_accumulator.clear
    @number_of_dice_available = Game::TOTAL_NUMBER_OF_DICE
  end
  
  def play
    begin
      roll
    end while !over? && confirm?
    player.game_accumulator.update( player.turn_accumulator )
    output_stream.puts first_part_of_roll_status_message if over?
    output_stream.puts( '=' * 30 )
  end
  
  def confirm?
    output_stream.print roll_status_message
    answer = input_stream.gets.chomp
    output_stream.puts
    /^y/i =~ answer
  end
  
  def over?
    @over
  end    
  
  def roll_predictably( roll_values )
    @last_roll_values = roll_values
    scorer = Scorer.new( @last_roll_values )
    score = scorer.score
    @over = score == 0
    @player.turn_accumulator.update( score )
    @number_of_dice_available = scorer.number_of_non_scoring_dice
    @number_of_dice_available = Game::TOTAL_NUMBER_OF_DICE if @number_of_dice_available == 0 
  end  
  
  def roll( number_of_dice = @number_of_dice_available )
    dice_set = DiceSet.new
    dice_set.roll( number_of_dice )
    roll_predictably( dice_set.values )
  end
  
  def first_part_of_roll_status_message
    "You just rolled #{@last_roll_values}, and you have accumulated #{@player.turn_accumulator.value} turn points."
  end
  
  def roll_status_message
    roll_status_message = first_part_of_roll_status_message + "\n"
    dice_or_die = @number_of_dice_available > 1 ? 'dice' : 'die'
    roll_status_message << <<STATUS_MESSAGE
Do you wish to roll your #{@number_of_dice_available} remaining #{dice_or_die} (yes/[no]) ? 
STATUS_MESSAGE
    roll_status_message.chomp
  end
  
  def output_stream
    game.output_stream
  end
  
  def input_stream
    game.input_stream
  end
  
  private :output_stream, :input_stream
  
end

require 'accumulator'

class ValidNameError < RuntimeError
end

class Player
  include Comparable
  attr_reader :name, :turn_accumulator, :game_accumulator
  
  def initialize( name )
    raise ValidNameError unless name.respond_to?(:to_str)
    @name = String.new(name)
    normalize_name
    @turn_accumulator = TurnAccumulator.new
    @game_accumulator = GameAccumulator.new
  end
  
  def <=>( other_player )
    self.name <=> other_player.name
  end
  
  def eql?( other_player)
    self.name.eql?( other_player.name )
  end
  
  def hash
    name.hash
  end
  
  def normalize_name
    @name = @name.strip.squeeze
    raise ValidNameError if @name.empty?
  end

  private :normalize_name

end
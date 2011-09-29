class ValidNameError < RuntimeError
end

class Player
  include Comparable
  attr_reader :name
  
  def initialize( name )
    raise ValidNameError unless name.respond_to?(:to_str)
    @name = String.new(name)
    normalize_name
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
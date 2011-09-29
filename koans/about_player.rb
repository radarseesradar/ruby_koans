require File.expand_path(File.dirname(__FILE__) + '/edgecase')

require 'player'

class AboutPlayer < EdgeCase::Koan

  def test_player_should_be_created_with_a_name
    assert_equal 'John',Player.new('John').name
  end

  def test_player_should_raise_exception_when_created_without_a_name
    assert_raise(ArgumentError) do
      Player.new
    end
  end
  
  def test_player_name_should_not_be_empty
    assert_raise(ValidNameError) do
      Player.new('     ')
      Player.new('')
    end
  end
  
  def test_player_name_should_ignore_whitespace
    assert_equal Player.new('John Doe').name, Player.new(' John   Doe  ').name
  end
  
  def test_players_should_be_comparable
    assert_equal Player.new('John Doe'), Player.new('John Doe')
  end
  
  def test_remove_duplicate_players_from_array
    assert_equal 1, [Player.new('John Doe'), Player.new('John Doe')].uniq.size
  end

end

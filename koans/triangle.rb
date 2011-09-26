# Triangle Project Code.

# Triangle analyzes the lengths of the sides of a triangle
# (represented by a, b and c) and returns the type of triangle.
#
# It returns:
#   :equilateral  if all sides are equal
#   :isosceles    if exactly 2 sides are equal
#   :scalene      if no sides are equal
#
# The tests for this method can be found in
#   about_triangle_project.rb
# and
#   about_triangle_project_2.rb
#


# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end

class Triangle
  def initialize( *sides )
    @sides = sides
    validate
    type
  end
  
  def number_of_equal_sides
    @sides.size - @sides.uniq.size + 1
  end
  
  def type
    case number_of_equal_sides
    when 3 then :equilateral
    when 2 then :isosceles
    else :scalene
    end
  end
  
  def validate
    raise TriangleError if @sides.size != 3 || @sides.any? { | side | side <= 0 }
    enumerator = @sides.each
    enumerator.with_index do | this_side, index |
      other_sides = Array.new( @sides )
      other_sides.slice!( index )
      raise TriangleError unless other_sides.inject(&:+) > this_side
    end
  end
  
end


def triangle(a, b, c)
  Triangle.new(a, b, c).type
end

=begin 
P:
  Implicit requirements:
    Create 3 instance methods for the Triplet class and one class method.

    The class method takes as input a min factor, max factor and sum,
    It returns an array of triplets (in arrays)

    Rules (implicit)
    - The squares will be input in order (otherwise add sort to pythagorean method)
E:

D:
  Input =
  Output =

A:

   -
   -
   -
   -
   -
   -

C:

=end


class Triplet
  
  def initialize(a, b, c)
    @sides = [a, b, c]
  end
  
  def sum
    sides.sum
  end
  
  def product
    sides.reduce(&:*)
  end
  
  def pythagorean
    squares = sides.map { |side| side ** 2 }
    squares[0] + squares [1] == squares[2]    
  end
  
  def self.where(sum:, min_factor:, max_factor:)
    enum = Enumerator.new do |y|
      x = 1
      loop do
        fract = Rational(x*(4*x + 4) + (4 * x + 3), 4*x + 4)
        a, b = fract.numerator, fract.denominator
        c = Math.sqrt(a**2 + b**2).to_i
        plato_triple = [a,b,c].sort
        y << plato_triple
        x += 1
      end
    end
    enum.take(max_factor)
  end
  
  private

  attr_reader :sides
end
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
  attr_reader :sides

  def initialize(a, b, c)
    @sides = [a, b, c]
  end
  
  def sum
    sides.sum
  end
  
  def product
    sides.reduce(&:*)
  end
  
  def pythagorean?
    squares = sides.map { |side| side ** 2 }
    squares[0] + squares [1] == squares[2]    
  end
  
  def self.where(sum: 0, min_factor: 3, max_factor: 100)
    enum = Enumerator.new do |y|
      x = 1
      loop do
        c = Math.sqrt(x**2 + (x + 1)**2)
        fermat_candidate = [x, x+1, c]
        if c - x - 2 == 0
          if Triplet.new(*fermat_candidate).pythagorean?
            fermat_candidate = Triplet.new(*fermat_candidate.map(&:to_i))
            y << fermat_candidate
            doubles = (fermat_candidate.sides.map { |side| side * 2 })
            triples = (fermat_candidate.sides.map { |side| side * 3 })
            y << Triplet.new(*doubles)
            y << Triplet.new(*triples)
          end
        end
        
        plato_candidate = Triplet.new(*Plato.fractional_triplet(x))
        y << plato_candidate unless plato_candidate.sides == fermat_candidate.sides unless fermat_candidate.class == Array

        pythag_candidate = Triplet.new(*Pythagorean.fractional_triplet(x))
        y << pythag_candidate

        x += 1
      end
    end
    enum
      .take(max_factor * 2)
      .sort_by { |trip| trip.sides }
      .drop_while { |trip| trip.sides[0] < min_factor}
      .take_while { |trip| trip.sides.last <= max_factor }
      # .select { |trip| sum.zero? ? true : (trip.sides.sum == sum) }
  end
end

# From https://en.wikipedia.org/wiki/Formulas_for_generating_Pythagorean_triples#Progressions_of_whole_and_fractional_numbers

class Plato < Triplet
  def self.fractional_triplet(x)
    fract = x + Rational(x, 2*x + 1)
    a, b = fract.numerator, fract.denominator
    c = Math.sqrt(a**2 + b**2).to_i
    [a,b,c].sort
  end
end

class Pythagorean < Triplet
  def self.fractional_triplet(x)
    fract = Rational(x*(4*x + 4) + (4 * x + 3), 4*x + 4)
    a, b = fract.numerator, fract.denominator
    c = Math.sqrt(a**2 + b**2).to_i
    [a,b,c].sort
  end
end

p triplets = Triplet.where(max_factor: 100)  # => [#<Triplet:0x00007fffc9f284a8 @sides=[3, 4, 5]>, #<Triplet:0x00007fffc9f28408 @sides=[6, 8, 10]>, #<Triplet:0x00007fffc9f28250 @sides=[7, 24, 25]>, #<Triplet:0x00007fffc9f28840 @sides=[8, 15, 17]>, #<Triplet:0x00007fffc9f283b8 @sides=[9, 12, 15]>, #<Triplet:0x00007fffc9f285c0 @sides=[12, 35, 37]>, #<Triplet:0x00007fffc9f28160 @sides=[16, 63, 65]>]
  # => [#<Triplet:0x00007fffc9f284a8 @sides=[3, 4, 5]>,
  #     #<Triplet:0x00007fffc9f28408 @sides=[6, 8, 10]>,
  #     #<Triplet:0x00007fffc9f28250 @sides=[7, 24, 25]>,
  #     #<Triplet:0x00007fffc9f28840 @sides=[8, 15, 17]>,
  #     #<Triplet:0x00007fffc9f283b8 @sides=[9, 12, 15]>,
  #     #<Triplet:0x00007fffc9f285c0 @sides=[12, 35, 37]>,
  #     #<Triplet:0x00007fffc9f28160 @sides=[16, 63, 65]>]

# >> [#<Triplet:0x00007fffc9f284a8 @sides=[3, 4, 5]>, #<Triplet:0x00007fffc9f28408 @sides=[6, 8, 10]>, #<Triplet:0x00007fffc9f28250 @sides=[7, 24, 25]>, #<Triplet:0x00007fffc9f28840 @sides=[8, 15, 17]>, #<Triplet:0x00007fffc9f283b8 @sides=[9, 12, 15]>, #<Triplet:0x00007fffc9f285c0 @sides=[12, 35, 37]>, #<Triplet:0x00007fffc9f28160 @sides=[16, 63, 65]>] #<Triplet:0x00007fffc8fc4520 @sides=[8, 15, 17]>,
  #     #<Triplet:0x00007fffc8fc4098 @sides=[9, 12, 15]>,
  #     #<Triplet:0x00007fffc8fc42a0 @sides=[12, 35, 37]>,
  #     #<Triplet:0x00007fffc8e13d98 @sides=[16, 63, 65]>]

# >> [#<Triplet:0x00007fffc8fc4188 @sides=[3, 4, 5]>, #<Triplet:0x00007fffc8fc40e8 @sides=[6, 8, 10]>, #<Triplet:0x00007fffc8e13e88 @sides=[7, 24, 25]>, #<Triplet:0x00007fffc8fc4520 @sides=[8, 15, 17]>, #<Triplet:0x00007fffc8fc4098 @sides=[9, 12, 15]>, #<Triplet:0x00007fffc8fc42a0 @sides=[12, 35, 37]>, #<Triplet:0x00007fffc8e13d98 @sides=[16, 63, 65]>]
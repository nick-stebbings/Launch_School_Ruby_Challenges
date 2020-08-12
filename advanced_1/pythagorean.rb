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
  
  def self.where(sum: nil, min_factor: 1, max_factor: 100)
    enum = Enumerator.new do |y|
      x = 1
      loop do
        c = Math.sqrt(x**2 + (x + 1)**2)
        fermat_candidate = [x, x+1, c]  # => [1, 2, 2.23606797749979], [2, 3, 3.605551275463989], [3, 4, 5.0], [4, 5, 6.4031242374328485], [5, 6, 7.810249675906654], [6, 7, 9.219544457292887], [7, 8, 10.63014581273465], [8, 9, 12.041594578792296], [9, 10, 13.45362404707371], [10, 11, 14.866068747318506], [11, 12, 16.278820596099706], [12, 13, 17.69180601295413], [13, 14, 19.1049731745428], [14, 15, 20.518284528683193], [15, 16, 21.93171219946131], [16, 17, 23.345235059857504], [17, 18, 24.758836806279895], [18, 19, 26.1725046566048], [19, 20, 27.586228448267445], [20, 21, 29.0], [21, 22, 30.4138126514911], [22, 23, 31.827660925679098], [23, 24, 33.24154027718932], [24, 25, 34.655446902326915], [25, 26, 36.069377593742864], [26, 27, 37.48332962798263], [27, 28, 38.897300677553446], [28, 29, 40.311288741492746], [29, 30, 41.72529209005013], [30, 31, 43.139309220245984], [31, 32, 44.553338819890925], [32, 33, 45.967379738244816], [33, 34, 47.38143096192854], [34, 35, 48.79549159502341]...
        if c - x - 2 == 0
          if Triplet.new(*fermat_candidate).pythagorean?
            fermat_candidate = Triplet.new(*fermat_candidate.map(&:to_i))
            y << fermat_candidate

            plato_candidate = Triplet.new(*Plato.fractional_triplet(x))  # => #<Triplet:0x00007fffbafab600 @sides=[7, 24, 25]>
            y << plato_candidate unless plato_candidate.sides == fermat_candidate.sides

            (2..4).each do |i|
              y << Triplet.new(*fermat_candidate.sides.map { |side| side * i })
            end
          end
        end
        pythag_candidate = Triplet.new(*Pythagorean.fractional_triplet(x))  # => #<Triplet:0x00007fffbadf2480 @sides=[8, 15, 17]>, #<Triplet:0x00007fffbafabc90 @sides=[12, 35, 37]>, #<Triplet:0x00007fffbafab150 @sides=[16, 63, 65]>, #<Triplet:0x00007fffbafaac28 @sides=[20, 99, 101]>, #<Triplet:0x00007fffbafaa700 @sides=[24, 143, 145]>, #<Triplet:0x00007fffbafaa1d8 @sides=[28, 195, 197]>, #<Triplet:0x00007fffbafa9cb0 @sides=[32, 255, 257]>, #<Triplet:0x00007fffbafa9788 @sides=[36, 323, 325]>, #<Triplet:0x00007fffbafa9260 @sides=[40, 399, 401]>, #<Triplet:0x00007fffbafa8d38 @sides=[44, 483, 485]>, #<Triplet:0x00007fffbafa8810 @sides=[48, 575, 577]>, #<Triplet:0x00007fffbafa82e8 @sides=[52, 675, 677]>, #<Triplet:0x00007fffbadde430 @sides=[56, 783, 785]>, #<Triplet:0x00007fffbadddc88 @sides=[60, 899, 901]>, #<Triplet:0x00007fffbaddd5d0 @sides=[64, 1023, 1025]>, #<Triplet:0x00007fffbaddcf18 @sides=[68, 1155, 1157]>, #<Triplet:0x00007fffbaddc338 @sides=[72, 1295, 1297]>, #<Triplet:0x00007...
        y << pythag_candidate

        x += 1
      end
    end
    enum
      .take(max_factor)
      .sort_by { |trip| trip.sides }  # => [#<Triplet:0x00007fffbafab768 @sides=[3, 4, 5]>, #<Triplet:0x00007fffbafab330 @sides=[6, 8, 10]>, #<Triplet:0x00007fffbafab600 @sides=[7, 24, 25]>, #<Triplet:0x00007fffbadf2480 @sides=[8, 15, 17]>, #<Triplet:0x00007fffbafab2b8 @sides=[9, 12, 15]>, #<Triplet:0x00007fffbafab240 @sides=[12, 16, 20]>, #<Triplet:0x00007fffbafabc90 @sides=[12, 35, 37]>, #<Triplet:0x00007fffbafab150 @sides=[16, 63, 65]>, #<Triplet:0x00007fffbafaac28 @sides=[20, 99, 101]>, #<Triplet:0x00007fffbafaa700 @sides=[24, 143, 145]>, #<Triplet:0x00007fffbafaa1d8 @sides=[28, 195, 197]>, #<Triplet:0x00007fffbafa9cb0 @sides=[32, 255, 257]>, #<Triplet:0x00007fffbafa9788 @sides=[36, 323, 325]>, #<Triplet:0x00007fffbafa9260 @sides=[40, 399, 401]>, #<Triplet:0x00007fffbafa8d38 @sides=[44, 483, 485]>, #<Triplet:0x00007fffbafa8810 @sides=[48, 575, 577]>, #<Triplet:0x00007fffbafa82e8 @sides=[52, 675, 677]>, #<Triplet:0x00007fffbadde430 @sides=[56, 783, 785]>, #<Triplet:0x00007fffbadd...
      .drop_while { |trip| trip.sides[0] < min_factor}  # => [#<Triplet:0x00007fffbafab768 @sides=[3, 4, 5]>, #<Triplet:0x00007fffbafab330 @sides=[6, 8, 10]>, #<Triplet:0x00007fffbafab600 @sides=[7, 24, 25]>, #<Triplet:0x00007fffbadf2480 @sides=[8, 15, 17]>, #<Triplet:0x00007fffbafab2b8 @sides=[9, 12, 15]>, #<Triplet:0x00007fffbafab240 @sides=[12, 16, 20]>, #<Triplet:0x00007fffbafabc90 @sides=[12, 35, 37]>, #<Triplet:0x00007fffbafab150 @sides=[16, 63, 65]>, #<Triplet:0x00007fffbafaac28 @sides=[20, 99, 101]>, #<Triplet:0x00007fffbafaa700 @sides=[24, 143, 145]>, #<Triplet:0x00007fffbafaa1d8 @sides=[28, 195, 197]>, #<Triplet:0x00007fffbafa9cb0 @sides=[32, 255, 257]>, #<Triplet:0x00007fffbafa9788 @sides=[36, 323, 325]>, #<Triplet:0x00007fffbafa9260 @sides=[40, 399, 401]>, #<Triplet:0x00007fffbafa8d38 @sides=[44, 483, 485]>, #<Triplet:0x00007fffbafa8810 @sides=[48, 575, 577]>, #<Triplet:0x00007fffbafa82e8 @sides=[52, 675, 677]>, #<Triplet:0x00007fffbadde430 @sides=[56, 783, 785]>, #<Trip...
      .select { |trip| trip.sides.last <= max_factor }  # => [#<Triplet:0x00007fffbafab768 @sides=[3, 4, 5]>, #<Triplet:0x00007fffbafab330 @sides=[6, 8, 10]>, #<Triplet:0x00007fffbafab600 @sides=[7, 24, 25]>, #<Triplet:0x00007fffbadf2480 @sides=[8, 15, 17]>, #<Triplet:0x00007fffbafab2b8 @sides=[9, 12, 15]>, #<Triplet:0x00007fffbafab240 @sides=[12, 16, 20]>, #<Triplet:0x00007fffbafabc90 @sides=[12, 35, 37]>, #<Triplet:0x00007fffbafab150 @sides=[16, 63, 65]>]
      .select { |trip| !sum || (trip.sides.last ** 2 >= sum) }  # => [#<Triplet:0x00007fffbafab600 @sides=[7, 24, 25]>, #<Triplet:0x00007fffbadf2480 @sides=[8, 15, 17]>, #<Triplet:0x00007fffbafab2b8 @sides=[9, 12, 15]>, #<Triplet:0x00007fffbafab240 @sides=[12, 16, 20]>, #<Triplet:0x00007fffbafabc90 @sides=[12, 35, 37]>, #<Triplet:0x00007fffbafab150 @sides=[16, 63, 65]>]
        # => [#<Triplet:0x00007fffbafab600 @sides=[7, 24, 25]>,
        #     #<Triplet:0x00007fffbadf2480 @sides=[8, 15, 17]>,
        #     #<Triplet:0x00007fffbafab2b8 @sides=[9, 12, 15]>,
        #     #<Triplet:0x00007fffbafab240 @sides=[12, 16, 20]>,
        #     #<Triplet:0x00007fffbafabc90 @sides=[12, 35, 37]>,
        #     #<Triplet:0x00007fffbafab150 @sides=[16, 63, 65]>]
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

 triplets = Triplet.where(sum: 180, max_factor: 100)  # => [#<Triplet:0x00007fffbafab600 @sides=[7, 24, 25]>, #<Triplet:0x00007fffbadf2480 @sides=[8, 15, 17]>, #<Triplet:0x00007fffbafab2b8 @sides=[9, 12, 15]>, #<Triplet:0x00007fffbafab240 @sides=[12, 16, 20]>, #<Triplet:0x00007fffbafabc90 @sides=[12, 35, 37]>, #<Triplet:0x00007fffbafab150 @sides=[16, 63, 65]>]
  # => [#<Triplet:0x00007fffbafab600 @sides=[7, 24, 25]>,
  #     #<Triplet:0x00007fffbadf2480 @sides=[8, 15, 17]>,
  #     #<Triplet:0x00007fffbafab2b8 @sides=[9, 12, 15]>,
  #     #<Triplet:0x00007fffbafab240 @sides=[12, 16, 20]>,
  #     #<Triplet:0x00007fffbafabc90 @sides=[12, 35, 37]>,
  #     #<Triplet:0x00007fffbafab150 @sides=[16, 63, 65]>]

=begin 
    P:
    Write two methods: 
 - one that takes a Rational number as an argument, and returns an Array of the denominators that are part of an Egyptian Fraction 
    representation of the number, 
- another that takes an Array of numbers in the same format,
    and calculates the resulting Rational number. You will need to use the Rational class provided by Ruby.
    E:
    
    D1:
      Input = Rational
      Output = array of distinct ints
    D2:
      Input = array of distinct ints
      Output = rational
    
    A: 
    = Egyptian
    - set a counter for the unit fraction denominator, denom, set to 1
    - Create a rational number object, Rational(1, denom)
    - set a blank variable, rem, to hold the remainders
       WHILE rem is greater than 0
       - IF the remainder i
       -  rem is greater than 0, divmod it by denom, add denom to results array
         - Set the remainder to a variable rem
       -
    = unegyptian
       -
       -
    
    C:
    
=end
Rational(3,2)  # =>
    def egyptian(rational)
      denom_counter = 1
      remainder = rational
      results = []

      while remainder > 0
         contender = Rational(1,denom_counter)
         remainder, next_denom = remainder.divmod(contender)  
         results.push(contender)
         p remainder, next_denom  # =>
      end
    end

egyptian(Rational(3,2))  # =>
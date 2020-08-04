
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

    def egyptian(leftover)
      denom_counter = 0
      results = []

      until leftover == 0
        denom_counter += 1
        contender = Rational(1,denom_counter)
        
        next if leftover < contender
        leftover -= contender
        results.push(denom_counter)
      end
      results
    end

    def unegyptian

    end
    
p egyptian(Rational(3,2))                                                           # => [1, 2]
p egyptian(Rational(2, 1))    # -> [1, 2, 3, 6]                                     # =>
p egyptian(Rational(137, 60)) # -> [1, 2, 3, 4, 5]                                  # =>
p egyptian(Rational(3, 1))    # -> [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 230, 57960]  # =>
                                                                                    # => [1, 2, 3, 6]
# unegyptian(egyptian(Rational(1, 2))) == Rational(1, 2)
# unegyptian(egyptian(Rational(3, 4))) == Rational(3, 4)
# unegyptian(egyptian(Rational(39, 20))) == Rational(39, 20)
# unegyptian(egyptian(Rational(127, 130))) == Rational(127, 130)
# unegyptian(egyptian(Rational(5, 7))) == Rational(5, 7)
# unegyptian(egyptian(Rational(1, 1))) == Rational(1, 1)
# unegyptian(egyptian(Rational(2, 1))) == Rational(2, 1)
# unegyptian(egyptian(Rational(3, 1))) == Rational(3, 1)

# >> [1, 2, 3, 6]
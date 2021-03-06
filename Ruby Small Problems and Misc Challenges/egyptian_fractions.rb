# A:
# = Egyptian
# - //set a counter for the unit fraction denominator, denom, set to 1
# - /set contender, a rational number object, Rational(1, denom_counter)
# - //DO
#
#    - IF the remainder is greater than 1/denom_counter
#     -  && IF rem is greater than 0, divmod it by denom, add denom to results array
#        - Set the remainder to a variable rem
#    - ELSE next

# //WHILE rem is greater than 0

# = unegyptian
#    -
#    -
#
#   P:
#   Given a Rational Object, calculate it Egyptian Fraction equivolant. Egyptian fractions the numerator is always a 1, and the denominator is never the same.
#
#   E:
#   egyptian(Rational(2, 1))    # -> [1, 2, 3, 6] -> 1/1, 1/2, 1/3, 1/6
#   egyptian(Rational(137, 60)) # -> [1, 2, 3, 4, 5]
#   egyptian(Rational(3, 1))    # -> [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 230, 57960]
#
#   D:
#
#     Input: Rational Object
#
#     Output: Array of denominators
#
#   A:
#
#     SET- flag, temp_sum, denominator
#
#     ITERATE-
#
#     IF-
#
#     ELSE-
#
#     PRINT-
#
#   C:
#
require 'pry'
def egyptian_recursive(rational); end

def egyptian(rational)
  denom_counter = 1
  remainder = rational
  results = []

  loop do
    if Rational(1, denom_counter) <= remainder
      remainder -= Rational(1, denom_counter)
      results.push(denom_counter)
    end
    denom_counter += 1
    break if remainder.zero?
  end
  results
end
p egyptian(Rational(2, 1))    # -> [1, 2, 3, 6]  # =>
p egyptian(Rational(137, 60)) # -> [1, 2, 3, 4, 5]  # =>
p egyptian(Rational(3, 1))

def unegyptian(denominators_ary)
  accum = 0
  denominators_ary.each do |denom|
    accum += Rational(1, denom)
  end
  accum
end

p unegyptian(egyptian(Rational(2, 1)))
p unegyptian(egyptian(Rational(137, 60)))
p unegyptian(egyptian(Rational(3, 1)))

# Somebnody else's nice recursive solution

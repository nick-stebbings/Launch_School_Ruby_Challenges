=begin 
Perfect Number

The Greek mathematician Nicomachus devised a classification scheme for natural numbers, identifying each as belonging uniquely to the categories of abundant, perfect, or deficient. 

A perfect number equals the sum of its positive 
divisors — the pairs of numbers whose product yields the target number, excluding the number itself.
This sum is known as the Aliquot sum.

Perfect: Sum of factors = number
    Abundant: Sum of factors > number
    Deficient: Sum of factors < number
    
    
    P:
    Write a program that can tell if a number is perfect, abundant or deficient. =end
    =begin 
    IMPLICIT: Input will be a number
    EXPLICIT: raise Runtime error for a negative number

    E:
    6 is a perfect number because its divisors are 1, 2, 3 and 6 = 1 + 2 + 3.
    28 is a perfect number because 28 = 1 + 2 + 4 + 7 + 14.
    Prime numbers 7, 13, etc are deficient by the Nicomachus classification.
    
D:
  Input = INT
  Output = a string, deficient abundant or perfect

A:
   - SUBPROCESS work out the factors for n
      - ITERATE through the range from 1..num
      - SET a factors ary
        - FOREACH num IF the num divides evenly into n, push it to the factors ary
   - aliquot = factors_ary.sum
   - case statement for aliquot

C:

=end
require 'pry'
class PerfectNumber
  def self.classify(n)
    raise RuntimeError if n <= 0

    factors = (1..n/2).each_with_object([]) { |num, factors| factors << num if (n % num).zero? }
    aliquot = factors.sum || 0
    case
    when aliquot == n
      'perfect'
    when aliquot < n
      'deficient'
    else 
      'abundant'
    end
  end
end
=begin 
P:
Write a program that can detect palindrome products in a given range.

A palindromic number reads the same both ways. 
The largest palindrome made from the product of two 2-digit numbers 
(range 10 ~ 99) is 9009 = 91 x 99.

Definition: palindrome product - a palindromic number which is a product of two other numbers

D:
  Input = two ints
  Output = see method algos

A:
# ///SET palindromes (instance variable)

#/// is_palindrome_prduct? method
 - multiply num1, num2
 - take the string of the resulting integer, split it into chars array
 - IF the length is even
   - THEN take the subarray that is the second half
- ELSE take the subarray from the middle + 1'th element to the end
   - iterate through the chars, comparing to the original array.
   - IF the chars differ, return false
   - return true

#/// Constructor method
   - Takes two named arguments: max factor and min factor
   - stores a range as instance variable
   
   # ///generate method - generates all palindromes in the range, stores state
   - Iterate through the range, 
    - FOREACH element in the iteration, multiply it with a 
    - IF the product is_palindrome?
      - Instantiate new Palindrome objects with factors and value i.v.'s 
      - 
   - ///REASSIGN i.v. palindromes to the results
   - assign smallest, largest instance variables to Palindrom objects, or just create methods which return the last/first elements of the palinromes array

  
   
# smallest method
  - a palindrome object that responds to #value and #factors
  -
# largest method
  - a palindrome object that responds to #value and #factors
  -
## smallest/largest methods
  # value method
    - returns the palindrome as int
    
  # factors method
    - returns a 2d array with pairs of integers equal in magnitued
=end

Palindrome = Struct.new(:factors, :value)

class Palindromes
  def initialize(max_factor: 1, min_factor: 1)
    @palindromes = {}
    @range = min_factor..max_factor
  end

  def generate
    @range.each do |f1|
      @range.each do |f2|
        product = f1 * f2
        if is_palindrome_product?(f1, f2)
          instance = find_palindrome_instance(product)
          if !instance
            @palindromes[product] = Palindrome.new([[f1, f2]], product)
          elsif !instance.factors.include?([f2, f1])
            instance.factors << [f1, f2]
          end
        end
      end
    end
  end

  def find_palindrome_instance(product)
    @palindromes[product]
  end

  def is_palindrome_product?(num1, num2)
    product_ary = (num1 * num2).to_s.chars
    reversed_half = product_ary[(product_ary.size / 2.0).ceil..-1].reverse
    0.upto(reversed_half.length - 1) { |i| return false unless product_ary[i] == reversed_half[i] }
    true
  end

  def smallest
    @palindromes[@palindromes.keys.min]
  end

  def largest
    @palindromes[@palindromes.keys.max]
  end
end
# bonus_mxz_rotations.rb
# DS: Use number converted to string, split into chars ary, then reconvert to int to pass into recursion
#A: Recursive: Base case: length of digits is 2
# OR base case is when a passed counter is equal to length -1
#  When you hit the base case, return the digit.to_s.chars.rotate(1).join.to_i
# Else concatenate the to_s of the digits
# edge case: only want to remove zeroes at the END
require 'pry'
def max_rotation(num)
  chars = num.digits.reverse
  result = num.to_s
  (result.size - 1).times do |k|
    result[k..-1] = chars.rotate(1).join
    chars = result[(k+1)..-1].chars
  end
  result.to_i
  end
  p max_rotation(735201)
  p max_rotation(105)
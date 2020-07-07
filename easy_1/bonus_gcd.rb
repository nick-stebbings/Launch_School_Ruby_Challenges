# gcd.rb

# Write a method that will return the greatest common divisor of two positive integers

# A: 
#  - ITERATE through the integers from 1.. the lowest of the inputs
#  - IF k divides into i1 and i2 without a remainder, set it as the greatest
#  - Do the above but do it in reverse and escape the loop when you have found one

def gcd(int1, int2)
  max_possible = [int1, int2].min
  max_possible.downto(1) do |k|
    return k if (int1 % k == 0 && int2 % k == 0)
  end

end
=begin 
P:
Translate decimals into Roman Numerals
E:
'VIII' = 8
Happy Path:
- Nil/empty
  return 0

- Input validation
 - raise argument error if number is not positive integer
- Edge cases:
  - any time the smaller number is before the larger number
   = we need to subtract the left-hand number from the right
  - 3000 is the top end
    try MMCMXDVII, 2947

Sad Path:
- Input validation

- Edge cases:



D:
  Input =  int > 0, < 3000
  Output =  string representing RN

A: // Define a to_roman method monkeypatched onto the Integer class.
   - CHECK that it's a valid integer
-- SET a results array (to be concatenated later), a DIGITS array to compare each integer digit
-- Determine the first number to push to the results array (the units)
   - THE NUMERAL ENDS IN I if
    - the decimal ends in one.. So shift off an array of the digits and compare with 1
-- Map to the NUMERAL UNITS constant, with an index shift of 1
  - the same is true of II and III
  - THE NUMERAL ENDS IN V if 
    - the decimal ends in 5
    
    - THE NUMERAL ENDS IN IV if 
    - the decimal ends in 4. 
    - THE NUMERAL ENDS IN IX if 
    - the decimal ends in 9
    
    - ELSE one of   X, L, C, D, M IF
    - the decimal ends in 0
-- We can safely process and remove this from the digits array after pushing the above to results. We are then left with the tens.
-- If the digits magnitude - 1 
 - 1, then we are just dealing with TENS
  -2, THEN we are dealing with 100s
  -3, THEN we are dealing with 1000s

   - IF the next digit is a 9
    - THEN the tens will be an 'odd case'
      - PUSH 'XC'
   - 8? 
    - PUSH LXXX
  - 7?
   - LXX
  - 6? LX
  - 5? L
  - 4? XL
  - 3?
   
  
  - A MORE GENERAL CASE:
   - Take the modulo of the whole number, or DIVMOD so you still retain the leftover integer
   - The num to use as the RHS of the modulo operator will be the NEXT in the constant array of DIVISORS.
   - So if we start with 1000, M, w
   e can just use DVMOD[1] * M to add to our results. The remainder will be our HUNDREDS
  - HUNDREDS can be divmodded again, then if the first element is 4, use CD. If 5 use D, if 

TEST ALGO:\
MMDXXXVII   =   2537.divmod(1000) =    2, 537   = MM, ..
IF the remainder starts with a 9, then use special case// NO

DXXXVII     =    537.divmod(500) =     1,  37   = 
XXXVII      =      37.divmod(10) =     3,   7

LENGTH OF DIGITS ARRAY = L()
LOOKUP INDEX OF NUMERALS_TENS.KEYS = L()-1

VII         =      7.divmod(10) =      0,   7 
Base case, units, just lookup in the UNITS constant


MMCMXDVII   =   2947.divmod(1000) =    2, 947   = MM, ..
IF the remainder starts with a 9, then use special case
CMXDVII     =    947.divmod(500) =     1, 447   = 
XDVII       =    447.divmod(100) =     4,  47
VII         =     47.divmod(10) =      4,   7 


=end

require 'pry'
class Integer
  ROMAN_NUMERAL_UNITS = ['', 'I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX']
  ROMAN_NUMERAL_FOURS = ['IV', 'XL', 'CD']
  ROMAN_NUMERAL_NINES = ['IX', 'XC', 'CM']
   ROMAN_NUMERAL_TENS = {
                        10 => 'X',
                        50 => 'L',
                        100 => 'C',
                        500 => 'D',
                        1000 => 'M'
                        }
  def to_roman
    dividend, remainder, results_string = self, 0, ''

    while ROMAN_NUMERAL_TENS.keys.any? { |divisor| dividend.divmod(divisor).first > 0 }
      next_biggest_divisor = ROMAN_NUMERAL_TENS.keys.select { |divisor| dividend.divmod(divisor).first != 0 }
      next_biggest_divisor.pop if dividend.digits.last == 9

      magnitude = dividend.digits.length
      tens, dividend = dividend.divmod(next_biggest_divisor.max)
      results_string << case
                        when tens == 9 then ROMAN_NUMERAL_NINES[magnitude - 1]
                        when tens == 4 then ROMAN_NUMERAL_FOURS[magnitude - 1]
                        else                ROMAN_NUMERAL_TENS[next_biggest_divisor.max] * tens
                        end
    end
    results_string << ROMAN_NUMERAL_UNITS[dividend]
  end
end

402.to_roman  # => "CDII"
# def a_method(num)
#   dividend =num
#   remainder = nil
#   results_string = ''

#   while ROMAN_NUMERAL_TENS.keys.any? { |divisor| dividend.divmod(divisor).first > 0 }
#     next_biggest_divisor = ROMAN_NUMERAL_TENS.keys.select do |divisor|
#       dividend.divmod(divisor).first != 0
#     end
#     tens, dividend = dividend.divmod(next_biggest_divisor.max)
    
#     results_string << case
#     when tens == 4 then magnitude - 1]
#     when tens == 9 then magnitude - 1]
#     else                ROMAN_NUMERAL_TENS[next_biggest_divisor.max] * tens
#     end
#   end
#   results_string << ROMAN_NUMERAL_UNITS[dividend]
# end


















=begin 
P:
Write a program that, given a 3 x 4 grid of pipes, underscores, and spaces, can determine which number is represented, or whether it is garbled.
Step One

To begin with, convert a simple binary font to a string containing 0 or 1. The binary font uses pipes and underscores, four rows high and three columns wide.

 _   #
| |  # zero.
|_|  #
     # the fourth row is always blank

Is converted to "0"

   #
|  # one.
|  #
   # (blank fourth row)

Is converted to "1"

If the input is the correct size, but not recognizable, your program should return '?'. If the input is the incorrect size, your program should return an error.
Step Two

Update your program to recognize multi-character binary strings, replacing garbled numbers with ?
Step Three

Update your program to recognize all numbers 0 through 9, both individually and as part of a larger string.

 _
 _|
|_

Is converted to "2"

  _  _     _  _  _  _  _  _  #
| _| _||_||_ |_   ||_||_|| | # decimal numbers.
||_  _|  | _||_|  ||_| _||_| #
                             # fourth line is always blank

Is converted to "1234567890"
Step Four

Update your program to handle multiple numbers, one per line. When converting several lines, join the lines with commas.

    _  _
  | _| _|
  ||_  _|

    _  _
|_||_ |_
  | _||_|

 _  _  _
  ||_||_|
  ||_| _|

Is converted to "123,456,789"
E:

D:
  Input =
  Output =

  Rules:
  If the string is potentially valid but contains areas that are not , those areas are marked with ? marks in the return string
  Implicit:
  - A valid string is made up of numbers represented by pipes and underscores.
  - A garbled number is one that does not match the pattern of ocr numbers
  - A valid digit will be 3 characters in width, 3 high
     _  _
  | _| _|
  ||_  _|

    _  _
|_||_ |_
  | _||_|

 _  _  _
  ||_||_|
  ||_| _|
   row1 '   '
   row2 ' |' ? 1, 2, 3 or 7
        '|_ '?  5 or 6
        '|_|'? 4, 8 or 9
A:
   - //are there 3 linebreaks? if no raise error
   - is it just pipe and underscores? if no raise
   - is the last line blank? return ?
   - does it contain valid numbers? yes, but some garbled: replace garbled with ?

  SPLIT each row into 3 char chunks array
   SET a results string
    -// split the strings into lengths of 3
    - does line1[0..2] match '   ' || ' _ ' ? if no add a ? and unshift the first 3 columns from rows
    - compare second line to branch off into correct digits.
   - use multiple case statements, returning ? to res_string if invalid

C:

=end

class OCR
  def initialize(text)
    lines = text.split("\n")
    raise ArgumentError unless lines.size <= 4
    @lines = lines
    @num_digits = @lines[1].size / 3
  end

  def convert
    result = ''
    @num_digits.times do |i|
      # There are only 2 chars for some first lines. Recalibrate alg.
      number_lines = @lines.map{ |line| line.slice((i * 3),3) }
      puts number_lines
    end
    
    '?'
  end
end
# OCR.new("h\nell\no\n ").convert  # => "?"

# >> h
# >> ell
# >> o
# >>  
# >> 
# >> 
# >> 
# >> 
# >> 
# >> 
# >> 
# >> 
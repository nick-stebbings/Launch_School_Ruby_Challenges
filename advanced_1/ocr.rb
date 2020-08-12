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
    @line_arrays = (text.split("\n").size > 4 ? text.split("\n").each_slice(4) : [lines])
    @result = ''
  end

  def convert
    @line_arrays.to_a  # => [["    _  _", "  | _| _|", "  ||_  _|", ""], ["    _  _", "|_||_ |_", "  | _||_|", ""], [" _  _  _", "  ||_||_|", "  ||_| _|"]]
    @line_arrays.each do |lines|
      lines  # => ["    _  _", "  | _| _|", "  ||_  _|", ""]
      num_digits = lines.max_by(&:size).size / 3  # => 3
      num_digits.times do |i|
        lines = lines.map{ |line| line.slice((i * 3),3) }  # => ["   ", "  |", "  |", ""], ["", "", "", nil]
        lines.map!{ |l| l.size < 3 ? l + ' ' : l } # ~> NoMethodError: undefined method `size' for nil:NilClass
        lines  # => ["   ", "  |", "  |", " "]
        
        @result << case 
        when lines[0].match?(/^\s+$/)
            if (lines[1] == '|_|')
              '4'
            elsif(lines[1] == '  |')
              '1'
            else
              '?'
            end
          when lines[0].match?(' _')
            case lines[2]
            when ' _|'
              case lines[1]
              when ' _|' then '3'
              when '|_|' then '9'
              when '|_ ' then '5'
              else '?'
              end
            when '|_|' then (lines[1] == '|_|' ? '8' : (lines[1] == '| |' ? '0' : '6'))
            when '  |' then '7'
            when '|_ ' then '2'
            else '?'
            end
          else
            '?'
          end
        end
    end
    @result
  end
end
  #   text = <<-NUMBER.chomp
  #      _     _        _  _
  # |  || |  || |  |  || || |
  # |  ||_|  ||_|  |  ||_||_|

  #   NUMBER
      # => :convert
    text = <<-NUMBER.chomp
    _  _
  | _| _|
  ||_  _|

    _  _
|_||_ |_
  | _||_|

 _  _  _
  ||_||_|
  ||_| _|

NUMBER
OCR.new(text).convert  # => 

# ~> NoMethodError
# ~> undefined method `size' for nil:NilClass
# ~>
# ~> ocr.rb:117:in `block (3 levels) in convert'
# ~> ocr.rb:117:in `map!'
# ~> ocr.rb:117:in `block (2 levels) in convert'
# ~> ocr.rb:115:in `times'
# ~> ocr.rb:115:in `block in convert'
# ~> ocr.rb:112:in `each'
# ~> ocr.rb:112:in `each_slice'
# ~> ocr.rb:112:in `each'
# ~> ocr.rb:112:in `convert'
# ~> ocr.rb:172:in `<main>'
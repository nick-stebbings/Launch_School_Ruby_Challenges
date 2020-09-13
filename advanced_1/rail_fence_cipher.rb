=begin 
P:
Implement encoding and decoding for the rail fence cipher.

The Rail Fence cipher is a form of transposition cipher that gets its name from the way in which it's encoded. It was already used by the ancient Greeks.

In the Rail Fence cipher, the message is written downwards on successive "rails" of an imaginary fence, then moving up when we get to the bottom (like a zig-zag). Finally the message is then read off in rows.

For example, using three "rails" and the message "WE ARE DISCOVERED FLEE AT ONCE", the cipherer writes out:

W . . . E . . . C . . . R . . . L . . . T . . . E
. E . R . D . S . O . E . E . F . E . A . O . C .
. . A . . . I . . . V . . . D . . . E . . . N . .


w     i     r      e     e
 e   d s   e e    e a   c
  a e   c v   d  l   t n
   r     o     f      o

n = 3 letter counts = 7, 12, 6
n = 3 letter counts = 5, 8, 8, 4

25 / 4,5

Then reads off:

WECRLTEERDSOEEFEAOCAIVDEN

To decrypt a message you take the zig-zag shape and fill the ciphertext along the rows.

? . . . ? . . . ? . . . ? . . . ? . . . ? . . . ?
. ? . ? . ? . ? . ? . ? . ? . ? . ? . ? . ? . ? .
. . ? . . . ? . . . ? . . . ? . . . ? . . . ? . .

The first row has seven spots that can be filled with "WECRLTE".

W . . . E . . . C . . . R . . . L . . . T . . . E
. ? . ? . ? . ? . ? . ? . ? . ? . ? . ? . ? . ? .
. . ? . . . ? . . . ? . . . ? . . . ? . . . ? . .

Now the 2nd row takes "ERDSOEEFEAOC".

W . . . E . . . C . . . R . . . L . . . T . . . E
. E . R . D . S . O . E . E . F . E . A . O . C .
. . ? . . . ? . . . ? . . . ? . . . ? . . . ? . .

Leaving "AIVDEN" for the last row.

W . . . E . . . C . . . R . . . L . . . T . . . E
. E . R . D . S . O . E . E . F . E . A . O . C .
. . A . . . I . . . V . . . D . . . E . . . N . .
#encode:
  n = 2, letter gap = 1  2
  n = 3, letter gap = 3  4
  n = 4, letter gap = 5  6
  n = 5, letter gap = 7  8

  1st row gap = 2n-3
  2nd row gap = 
  up to n/2

  nth row gap = e1st row gap


#decode:
  = is the original string length would end on the first row again once encoded !Not necessarily!
  
  Algo: - represent the characters with numbers based on a range that is the same length as the input string
        - this 'simulation' will give you the length of each row, which will allow you to split into rails and then
        - iterate through the rails shifting characters to a result string until there are none left
E:  

D:
  Input =
  Output =

A:
   - IF first row, then remove from string every 2n+3'th letter, join
   - concatenate joined letters to recursive call passing remaining letters, n-1
   - BASE CASE if n == 1 return whole string
   -
   -
   -

C:

=end

class RailFenceCipher
  class << self
    def encode2(str, number_of_rails) # Recursive solution
      return str if number_of_rails == 1 || str == '' || number_of_rails > str.length

      letters = str.chars
      rail = ''
      indices = []

      (0...letters.length).step(2 * number_of_rails - 3 + 1) do |i|
        indices << i # Save indices so we can remove the characters at those positions
        rail << letters[i]
      end
      indices.each_with_index { |i, i2| letters.delete_at(i - i2) }
      
      rail + encode(letters.join(''), number_of_rails - 1)
    end

    def decode(str, number_of_rails)
      return str if str == '' || number_of_rails > str.length || number_of_rails == 1
      
      letters = str.chars
      rails_template = zigzag((0...str.length).to_a.join(''), number_of_rails)  # => 

      result = ''
      decoded_rails = []
      i = 0

      rails_template.each do |rail| 
        next_rail = letters.take(rail.length).join('')
        i += next_rail.size 
        decoded_rails << next_rail
      end  # => 
      
      decoded_rails  # => 
    end

    def encode1(str, number_of_rails) # Iterative solution
      return str if str == '' || number_of_rails > str.length || number_of_rails == 1

      zigzag(str, number_of_rails).flatten.join('')
    end

    def encode(string, number_of_rails)
      rails = RailFramework.new(number_of_rails)
      
    end
    def zigzag(str, number_of_rails)
      rails_matrix = Array.new(number_of_rails) { Array.new {} }
      rails_index = 0
      direction = :down
      letters = str.chars

      while letters.length > 0
        rails_matrix[rails_index] << letters.shift
        rails_index = direction == :up ? (rails_index + 1) : (rails_index - 1)
        direction = change_direction(direction) if need_different_direction?(rails_index, number_of_rails, direction)  # => 
      end
      rails_matrix  # => 
    end

    # def need_different_direction?(rails_index, number_of_rails, direction)
    #   (rails_index == number_of_rails - 1) && direction == :down || rails_index == 0 && direction == :up
    # end

    # def change_direction(current_direction)
    #   current_direction == :up? ? :down : :up
    # end
  end
end
# test1 = RailFenceCipher.encode1('THISISJUSTATEST', 3)  # => 
# p RailFenceCipher.decode(test1, 3)  # => 
# RailFenceCipher.decode('WECRLTEERDSOEEFEAOCAIVDEN', 3)  # => ["WECRLTEERD", "WECRLTEERDSOEEFEAOCA", "WECRLTEERD"]
# RailFenceCipher.decode('XOXOXOXOXOXOXOXOXO', 2)  # => ["XOXOXOXOXOXOX", "XOXOXOXOXOXOX"]

#  S          G       H
#   W . . . E  R. . .I   C . . . R . . . L . . . T . . . E
#   . E . R .   D . S .   O . E . E . F . E . A . O . C .
#   . . A . . .   I . . .   V . . . D . . . E . . . N . .


  # CALCULATE repeating cycle for top row
  # then repeating cycle for rth rail is that -2, starting from char (r)
# # 0,6,12,18    r = 0
#   1  5  7  11      1    r, -2 +4 -8 
#   2  4  8  10      2    r  -4 -6  -10
# # i = 
# 0,1,2,3   4
# n = 4
#   +2, +4, +6
#   (i*n + (n-2)i)

# W . . . E . . . C . . . R . . . L . . . T . . . E
# . E . R . D . S . O . E . E . F . E . A . O . C .
# . . A . . . I . . . V . . . D . . . E . . . N . .
# 0,4,8,12,16      (i * n + (n-2)i)
# i = 
# 0,1,2,3   4
# n = 3


# E . R . D . S . O . E . E . F . E . A . O . C .
# . A . . . I . . . V . . . D . . . E . . . N . .
#  ,2,4,6,8         2i  (i * n + 0)
# 0,1,2,3   2



class RailFramework
  attr_reader :character_index_enumerators, :rail_indices

  def initialize(number_of_rails)
    @n = number_of_rails
    @character_index_enumerators = Array.new(number_of_rails) do |rail_index|
      get_character_index_enumerator(rail_index)
    end
    @rail_indices = rail_index_enumerator
  end
  
  def rail_index_enumerator
    (0.upto(@n - 1).to_a + (@n - 2).downto(1).to_a).cycle
  end

  def get_character_index_enumerator(rail_index)
    Enumerator.new do |yielder|
      char_index = 0 # Initial character index depends on rail  # =>
      going_down = 1
      loop do
        next_top_row_index  = char_index * @n + (@n - 2) * char_index  # => 0, 6,  12, 18
        interval_offset = going_down * rail_index  # => 1, -1, 1,  -1
next_top_row_index + interval_offset   # => 1, 5,  13, 17
        yielder << next_top_row_index + interval_offset  # => #<Enumerator::Yielder:0x00007fffb84b59a0>, #<Enumerator::Yielder:0x00007fffb84b59a0>, #<Enumerator::Yielder:0x00007fffb84b59a0>

        going_down = -going_down
        char_index += 1
      end
    end
  end

  def fill_rails(string)
    string.chars.each_with_object('') do |char, encoded_string|
      p character_index_enumerators[rail_indices.next].next  # => 
    end
  end

end

all_enums = RailFramework.new(4).character_index_enumerators  # => [#<Enumerator: #<Enumerator::Generator:0x00007fffb84b63c8>:each>, #<Enumerator: #<Enumerator::Generator:0x00007fffb84b6328>:each>, #<Enumerator: #<Enumerator::Generator:0x00007fffb84b6288>:each>, #<Enumerator: #<Enumerator::Generator:0x00007fffb84b61e8>:each>]
all_enums[1].take(4)  # => [1, 5, 13, 17]
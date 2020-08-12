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
  Implicit: the original string length would end on the first row again once encoded
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
  def self.encode(str, numrails)
    return str if numrails == 1 || str == '' || numrails > str.length
    letters = str.chars
    rail = ''
    indices = []

    (0...letters.length).step(2 * numrails - 3 + 1) do |i|
      indices << i # Save so we can remove them
      letters[i]
      rail << letters[i]
    end
    indices.each_with_index { |i, i2| letters.delete_at(i - i2) }
    rail + encode(letters.join(''), numrails - 1)
  end

  def self.decode(str, numrails)
    return str if str == '' || numrails > str.length || numrails == 1
  end
end
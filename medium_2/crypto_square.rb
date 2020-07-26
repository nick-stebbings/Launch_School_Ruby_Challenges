#
# P:
# Implement the classic method for composing secret messages called a square code.
#
#  - The input is first normalized: The spaces and punctuation are removed from the English text and the message is down-cased.
#
# -  Then, the normalized characters are broken into rows. These rows can be regarded as forming a rectangle when printed with intervening newlines.
#
# For example, the sentence
#
#     If man was meant to stay on the ground god would have given us roots
#
# is 54 characters long.
#
# Broken into 8-character columns, it yields 7 rows.
#
# Those 7 rows produce this rectangle when printed one per line:
#
# ifmanwas
# meanttos
# tayonthe
# groundgo
# dwouldha
# vegivenu
# sroots
#
# The coded message is obtained by reading down the columns going left to right. For example, the message above is coded as:
#
# imtgdvs fearwer mayoogo anouuio ntnnlvt wttddes aohghn sseoau
#
# Write a program that, given an English text, outputs the encoded version of that text.
#
# The size of the square (number of columns) should be decided by the length of the message.

# - If the message is a length that creates a perfect square (e.g. 4, 9, 16, 25, 36, etc),
#-  use that number of columns.
# - If the message doesn't fit neatly into a square,
# - choose the number of columns that corresponds to the smallest square that is larger than the number of characters in the message.
#
# P:
#
# E:
#
# D:
#   Input =
#   Output =
#
# A:
#    - calculate row length (num columns)
#      - It is the ceiling of the square root of the length of str

#    - calculate num rows:
#      - it is the floor of (str length divided by the row length)

#    - For each row, once the string is sanitised,
#      - push rowlength chars onto a subarray
#      - if there are not enough char left, use a space
#    - push the subarray onto the results array
#    - transpose the results array
#    - map it to join each sub array with spaces
#    - return this string
#
# C:
#
# For example, a message 4 characters long should use a 2 x 2 square. A message that is 81 characters long would use a square that is 9 columns wide. A message between 5 and 8 characters long should use a rectangle 3 characters wide.

class Crypto
  def initialize(input_str)
    @input_str = input_str
    @padded = plaintext_segments.map do |seg|
      seg.size == size ? seg : seg + ' ' * (size - seg.size)
    end
  end

  def normalize_plaintext
    @input_str.gsub(/[^a-z0-9]/i, '').downcase
  end

  def size
    Math.sqrt(normalize_plaintext.size).ceil
  end

  def plaintext_segments
    normalize_plaintext.split('').each_slice(size).map(&:join)
  end

  def ciphertext(joiner = '')
    @padded.map { |seg| seg.split('') }.transpose.map(&:join).map(&:strip).join(joiner)
  end

  def normalize_ciphertext
    ciphertext(' ')
  end
end

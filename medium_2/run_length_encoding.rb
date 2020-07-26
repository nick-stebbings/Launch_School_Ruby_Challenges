#
# P:
# Implement run-length encoding and decoding.
#
# Run-length encoding (RLE) is a simple form of data compression, where runs (consecutive data elements) are replaced by just one data value and count.
#
# E:
# For example we can represent the original 53 characters with only 13.
#
# "WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB"  ->  "12WB12W3B24WB"
#
# RLE allows the original data to be perfectly reconstructed from the compressed data, which makes it a lossless data compression.
#
# "AABCCCDEEEE"  ->  "2AB3CD4E"  ->  "AABCCCDEEEE"
#
# D:
#   Input = str
#   Output = str (for both methods)
#
# A:
# encode..
#    - split by consecutive letters
#    - map to ord of char
#    - count consecutive chunks where the code is the same
#     - push the number times the char onto a results string

# decode ..
#    - split on positive lookahead number
#    - map to a * of the character times the number
#    - return joined str

# Must work with special chars. Can you do a * with those?
# yes.

# C:
#

class RunLengthEncoding
  class << self
    def encode(input)
      chars = input.split('')
      chars
        .chunk_while { |a, b| a == b }
        .map do |chunk|
          if chunk.first == 32
            ' ' * chunk.size
          else
            chunk.size == 1 ? chunk.first : "#{chunk.size}#{chunk.first}"
          end
        end.join
    end

    def decode(input)
      input.gsub!(/(?<!\d)(\D)/i, '1' + '\1')
      input.gsub(/(\d*)(\D)/i) { Regexp.last_match[2] * Regexp.last_match[1].to_i }
    end
  end
end

RunLengthEncoding.encode('⏰⚽⚽⚽⭐⭐⏰') # => "⏰3⚽2⭐⏰"
RunLengthEncoding.decode('⏰3⚽2⭐⏰') # => "⏰⚽⚽⚽⭐⭐⏰"

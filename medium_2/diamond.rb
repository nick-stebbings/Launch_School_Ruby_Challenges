=begin 
P:
The diamond exercise takes as its input a letter, and outputs it in a diamond shape. Given a letter, it prints a diamond starting with 'A', with the supplied letter at the widest point.
Requirements

    The first row contains one 'A'.
    The last row contains one 'A'.
    All rows, except the first and last, have exactly two identical letters.
    The diamond is horizontally symmetric.
    The diamond is vertically symmetric.
    The diamond has a square shape (width equals height).
    The letters form a diamond shape.
    The top half has the letters in ascending order.
    The bottom half has the letters in descending order.
    The four corners (containing the spaces) are triangles.

E:
    string = "    A    \n"\
             "   B B   \n"\
             "  C   C  \n"\
             " D     D \n"\
             "E       E\n"\
             " D     D \n"\
             "  C   C  \n"\
             "   B B   \n"\
             "    A    \n"
D:
  Input =
  Output =

A:
   - take index of letter (ord - 97)
   - iterate through range of letters up to Input
   - with index
   - SET a results string
   - push letter index - index - 1 spaces onto front and back
   - push a newline

C:

=end
class Diamond
  def self.make_diamond(letter)
    raise ArgumentError unless ('A'..'Z').cover? letter
    range = ('A'..letter)
    alpha_index = range.to_a.size
    top = range.each_with_index.with_object('') do |(let, idx), results|
      gap_width = alpha_index - idx - 1
      gap = ' ' * gap_width
      results << (gap + let + (idx > 0 ? ((' ' * (idx *2 - 1)) + let + gap) : gap) + "\n")
  + "\n"
    end
    letter > 'A' ? top + top.split("\n")[0..-2].reverse.join("\n") + "\n" : top
  end
end
Diamond.make_diamond('C')  # => "  A  \n B B \nC   C\n B B \n  A  \n"

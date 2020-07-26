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
#    - MAP the reversed pieces array to a verses array
#    - FOR EACH piece, with index
#    - Concatenate to 'This is '
#    - concatenate to the previous verse
#    -
#    - insert two newlines after each verse( or join verses with them)
#
# C:
#
class House
  def self.recite
    verses = pieces.reverse.each_with_index.with_object([]) do |(piece, idx), verses|
      verses << ('This is ' +
        (idx.zero? ? piece.join(' ') : piece.join(' ') + "\n" + verses[idx - 1][8..-4]) +
        ".\n\n")
    end
    verses.join
  end

  def self.pieces
    [
      ['the horse and the hound and the horn', 'that belonged to'],
      ['the farmer sowing his corn', 'that kept'],
      ['the rooster that crowed in the morn', 'that woke'],
      ['the priest all shaven and shorn', 'that married'],
      ['the man all tattered and torn', 'that kissed'],
      ['the maiden all forlorn', 'that milked'],
      ['the cow with the crumpled horn', 'that tossed'],
      ['the dog', 'that worried'],
      ['the cat', 'that killed'],
      ['the rat', 'that ate'],
      ['the malt', 'that lay in'],
      ['the house that Jack built']
    ]
  end
end

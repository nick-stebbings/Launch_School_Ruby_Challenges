# odd_words.rb
=begin 
P:
  PD: Character set of letters, a space and a point

  RULES:
   - explicit: 
    - Words consist of one or more, but at most 20 letters
    - An input text consists of one or more words
      - separated by spaces
      - terminated by 0 or more spaces
      - followd by a point
      - Read from 1st letter of 1st word upto and including the terminating poin
  = implicit: 
   - odd and even refer to the count from the first word, e.g the in 'and then the cat jumped' is 3, hence odd
   - preserve case in the final result
  
   Successive words are to be separated by a single space
   - with the last word being terminated by a single point
  - Odd words are copied in reverse order
  - Even words are echoed

  //Bonus: the characters must be read and printed one at a time.

  
E:

Happy Path:
p odd_words('this.') == 'siht.'

- Nil/empty
p odd_words('') == ''


- Input validation
p odd_words('this is a test of reallysuperlongwordsssss.') == ''
p odd_words('this is a test of no period') == ''
p odd_words('this . is a test of wron period') == ''
p odd_words('this . is a test of wr0ng ch4r4ct$r S$tz.') == ''


- Edge cases:
p odd_words('this is a test of spaces  .') == 'this si a tset of secaps.'
p odd_words('s s s s s s') == 's s s s s s'

D:
  Input = string
  Output = string

A:
 - //if the input string doesn't match the format given in the spec, return ''
   -// Regex ... /^([a-zA-Z \.])$} 

   -// substitute out any extra space for a single one (any more than one, any before the final period can be removed with the period.
   -// with this sanitised string, remove the period
    - //then split on spaces
   -// map the resulting array with index
   - //for each element, if its index is odd, return the reversed element
   - //else return the element
   - join this mapped array on spaces
   - return joined string plus a period on the end

C:

=end
def odd_words(str)
  match_string = /^[a-z ]*.$/i
  words = str.gsub(/\s{1,}/, ' ').gsub(/\.$/, '').strip.split
  return '' unless str.match? match_string
  return '' if words.any? { |word| word.length > 20 }

  words.map!.with_index do |word, idx|
    idx.odd? ? word.reverse : word
  end
  "#{words.join(' ')}."
end
p odd_words('this is a test of reallysuperlongwordsssss.') == '' # alter regex

p odd_words('this.') == 'siht.'#
p odd_words('') == ''#
p odd_words('this is a test of no period') == ''
p odd_words('this . is a test of wron period') == ''
p odd_words('this . is a test of wr0ng ch4r4ct$r S$tz.') == ''
p odd_words('this is a test of spaces  .') == 'this si a tset of secaps.'# wrong result calculated first time
p odd_words('s s s s s s') == 's s s s s s.' #

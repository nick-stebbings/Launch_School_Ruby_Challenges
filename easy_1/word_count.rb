=begin 
P:
Write a program that given a phrase can count the occurrences of each word in that phrase.
RULES: explicit
- ignore punctuation
- lists separated by a , or by a ,\n should also delineate words
- /numbers count as words
- /count words of different case as the same instance
  - allow apostrophe's in words
  - count quoted words as the same instance as non-quoted equiv.
  RULES: implicit
   - the tests will expect the order of words in the sentence to be reflected in the counts hash
   - we will definitely get a valid string input
   - all words will have only one space between them to delineate
E:
"olly olly in come free"
olly: 2
in: 1
come: 1
free: 1
D:
  Input = str
  Output = hash

A:
 - method word_count 
   - /SET an empty hash, counts
   - /SANITISE the string by removing non ['a-zA-Z"\n, ] chars 
   -/ SET a words array to the string, SPLIT on spaces OR , OR ,\n (assume only one will be valid)
   - ITERATE through the words
    - FOREACH word downcased & stripped of bordering quotemarks, if it is in counts.keys, increment, else add it as a key with value 1
   -

C:

=end
# class Phrase
#   def initialize(phrase)
#     @phrase = phrase
#   end
  
#   def word_count
    
#     new_str = @phrase.gsub(/[^0-9A-Za-z "',\n]/, '')
#     words_ary = new_str.split(/(?>(,)+|(,\n)+)/).map{ |w| w.downcase.sub(/\A['"](.*)['"|,]\Z/, '\1') } # Remove quotes
#     individual_word_count = Proc.new { |word| words_ary.count { |w| w.match? %r{^#{word}$}i } } # Does it match when didregarding case?
#     word_instances = words_ary.uniq
#     word_instances.zip(word_instances.map{ |word|  individual_word_count.(word) }).to_h
#   end
# end

class Phrase
  def initialize(phrase)
    @phrase = phrase
  end

  def word_count
    words_list = @phrase.split(/[^0-9A-Za-z'"]/).reject { |el| el == '' }
    words_list.each_with_object({}) do |word, counts_hash|
      stripped_word = word.sub(/\A['"](.*)['"|,]\Z/, '\1').downcase
      counts_hash.key?(stripped_word) ? (counts_hash[stripped_word] += 1) : (counts_hash[stripped_word] = 1)
    end
  end
end





















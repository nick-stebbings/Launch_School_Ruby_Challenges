class Anagram
  def initialize(word)
    @word = word
  end
  
  def match(arr)
    all = all_same_length_anagrams(@word.downcase)
    arr.select { |word| all.include? word.downcase }.sort
  end

  private
  def all_same_length_anagrams(word)
    chars_ary = word.chars
    all = chars_ary.permutation(word.size).map(&:join)
    all - [word]
  end
end
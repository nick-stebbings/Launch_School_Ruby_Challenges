=begin 
P:
Implement a simple shift cipher like Caesar and a more secure substitution cipher.

Step 1:

    "If he had anything confidential to say, he wrote it in cipher, that is, by so changing the order of the letters of the alphabet, that not a word could be made out. If anyone wishes to decipher these, and get at their meaning, he must substitute the fourth letter of the alphabet, namely D, for A, and so with the others."

— Suetonius, Life of Julius Caesar

Ciphers are very straight-forward algorithms that allow us to render text less readable while still allowing easy deciphering. They are vulnerable to many forms of cryptoanalysis, but we are lucky that generally our little sisters are not cryptoanalysts.

The Caeser Cipher was used for some messages from Julius Caesar that were sent afield. Now Caeser knew that the cipher wasn't very good, but he had one ally in that respect: almost nobody could read well. So even being a couple letters off was sufficient so that people couldn't recognize the few words that they did know.

Your task is to create a simple shift cipher like the Caesar Cipher. This image is a great example of the Caesar Cipher:

Caesar Cipher

Here are some examples:

@cipher = Cipher.new
@cipher.encode("iamapandabear") #=> "ldpdsdqgdehdu"
@cipher.decode("ldpdsdqgdehdu") #=> "iamapandabear"

Step 2:

Shift ciphers are no fun though when your kid sister figures it out. Try amending the code to allow us to specify a key and use that for the shift distance. This is called a substitution cipher.

Step 3:

The weakest link in any cipher is the human being. Let's make your substitution cipher a little more fault tolerant by providing a source of randomness and ensuring that they key is not composed of numbers or capital letters.
#     If someone doesn't submit a key at all, generate a truly random key of at least 100 characters in length, accessible via Cipher#key (the # syntax means instance variable)

# If the key submitted has capital letters or numbers, throw an ArgumentError with a message to that effect.

E:

@cipher = Cipher.new
@cipher.key #=> "duxrceqyaimciuucnelkeoxjhdyduucpmrxmaivacmybmsdrzwqxvbxsygzsabdjmdjabeorttiwinfrpmpogvabiofqexnohrqu"

D:
  Input =
  Output =

A:

#encode
 - INPUT = string to encode (and key instance variable)
 - OUTPUT = str

 - MAP the key string into shift amounts

 - SET a characters array
 - MAP the characters array
  - FOREACH char in the char_array
  - GET ascii_code for char, subtract 96 to get index of letter
   - SET first_half letters = (a..m)
   - SET second_half letters = (n..z)

   - TRANSLATE the ascii_code by the shiftamount for that character

=end
class Cipher
  attr_reader :key
  def initialize(key = generate_key)
    raise ArgumentError unless key.match? /\A[a-z]+\Z/
    @key = key
    @shift_amounts = key.chars.map{ |c| c.ord - 97}
  end

  def encode(plaintext)
    new_charcodes = plaintext.chars.map.with_index do |ch, idx|
      new_ord = (( ch.ord - 97) + @shift_amounts[idx]) % 26
      (new_ord + 97).chr
    end
    new_charcodes.join
  end

  def decode(plaintext)
    new_chars = plaintext.chars.map.with_index do |ch, idx|
      new_ord = ((ch.ord - 97) - @shift_amounts[idx] + 26) % 26
      (new_ord + 97).chr
    end
    new_chars.join
  end

  private

  def generate_key
    str = ''
    alpha = ('a'..'z').to_a
    100.times { str << alpha.sample }
    str
  end
end
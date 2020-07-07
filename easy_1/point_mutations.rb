=begin Write a program that can calculate the Hamming distance between two DNA strands.

A mutation is simply a mistake that occurs during the creation or copying of a nucleic acid, in particular DNA. Because nucleic acids are vital to cellular functions, mutations tend to cause a ripple effect throughout the cell. Although mutations are technically mistakes, a very rare mutation may equip the cell with a beneficial attribute. In fact, the macro effects of evolution are attributable by the accumulated result of beneficial microscopic mutations over many generations.

The simplest and most common type of nucleic acid mutation is a point mutation, which replaces one base with another at a single nucleotide.

By counting the number of differences between two homologous DNA strands taken from different genomes with a common ancestor, we get a measure of the minimum number of point mutations that could have occurred on the evolutionary path between the two strands.

This is called the 'Hamming distance'

The Hamming distance is only defined for sequences of equal length. If you have two sequences of unequal length, you should compute the Hamming distance over the shorter length. =end

=begin 
P: - the Hamming distance is a measure of the amount of mutation between two DNA strands. Specifically the minimum no. of point mutations.
  - a point mutation is a difference of one base with another at a single nucleotide.
  - if the strands are of different lengths, truncate the longer, as you cannot compute for different lengths
    Implicit (from tests) :
    Happy Path:
    - Nil/empty
      '' and '' -> 0
    - Input validation
      there are no tests for invalid input, so ignore
    - Edge cases:
      # h.d. of 1, i.e. just one difference
      # one strand slightly longer than other (2)
    Sad Path:
    - Edge cases:
      no error raising implied from tests

PD definitions: 
 - a strand of nucleic acid: a string representing
  a DNA sequence. A string of G,T,C,A characters all uppercase
 -  a point mutation: the changing of a letter at that place in the string.
 - the Hamming Distance: the number of different characters between two given strings of the same length

E:
GAGCCTACTAACGGGAT
CATCGTAATGACGGCCT
^ ^ ^  ^ ^    ^^
The Hamming distance between these two DNA strands is 7.

D:
  Input = a string (to the initialize method),
  and a str (to hamming_distance)
  Output = int, (from hamming_distance)

A:
   - //A DNA class, with one instance method, hamming_distance
    - This method must return an integer
      - //SET first_strand_in_comparison
        - /IF the DNA's instance variable is longer, take a slice ///from it the length of input and assign to first_strand_in_comparison
        - //ELSEIF the input is longer, set it to the i.v. value
        - and also truncate the input to be the same length
      - //SET a counter at 0 for the h_d
      - //ITERATE, WITH INDEX through chars_arrays of both variables
        - IF element != first_strand_in_comparison_chars_ary[idx]
        - THEN increment counter
=end


    # min_length = [@first_strand, second_strand].map(&:length).min
    # first_strand_nucleotides = (@first_strand.length == min_length ? @first_strand : @first_strand[0..min_length.pred]).chars
    # second_strand_necleotides = (second_strand == min_length ? second_strand : second_strand[0..min_length.pred]).chars
class DNA
  attr_reader :first_strand

  def initialize(sequence)
    @first_strand = sequence
  end

  def hamming_distance(second_strand)
    return 0 if first_strand == '' || second_strand == ''
    shorter_strand = [first_strand, second_strand].min_by { |strand| strand.length }

    first_strand_nucleotides = (first_strand == shorter_strand ? first_strand : first_strand[0..(second_strand.size - 1)]).chars
    second_strand_nucleotides = (second_strand == shorter_strand ? second_strand : second_strand[0..(first_strand.size - 1)]).chars

    distance = 0

    first_strand_nucleotides.each_with_index do |nuc, idx|
      (distance += 1) if nuc != second_strand_nucleotides[idx]
    end
    distance
  end
end
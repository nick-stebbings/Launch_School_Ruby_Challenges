=begin 
P:
Write a program that takes a word problem and returns the answer as an integer.

E:

    What is 5 plus 13?

The program should return 18.

    What is 7 minus 5 minus 1?

The program should return 1.

Remember, that these are verbal word problems, not treated as you normally would treat a written problem. This means that you calculate as you move forward each step. This means 3 + 2 * 3 = 15, not 9.

D:
  Input = string
  Output = integer/float

A:
# - SUB the operators to the relevant operations, sub the final question mark to ''
# - plus to +
# - minus to -
# - divided by to /
# - multiplied by *

# - GUARD CLAUSE if the string is still the same, raise ArgError
# - SPLIT the string into words
  #  - GUARD CLAUSE if the first two elements are not [What, is] then raise ArgError
  #  - MAP the remaining nums/operators,
    # - IF .to_i.to_s is the same, map to_i
    # - ELSE map to sym
  # - SET a last_operator variable
  # - REDUCE the array, omitting args
    - IF element is a number, send the last operator with arguments (total, element)

C:

=end
class WordProblem
  def initialize(problem_string)
    @prob = problem_string
  end

  def answer
    mapped_str = map_string_to_operators
    raise ArgumentError if mapped_str == @prob || !@prob.start_with?('What is ') || !@prob.end_with?('?')

    operation_stack = mapped_str[8..-2].split
    operation_stack.map! do |op|
      op.to_i.to_s == op ? op.to_i : op.to_sym
    end
    perform_operations(operation_stack)
  end

  private

  def perform_operations(ary)
    last_operator = nil
    ary.reduce do |total, element|
      if element.is_a?(Symbol)
        last_operator = element
        next total
      end
      total.send(last_operator, element)
    end
  end

  def map_string_to_operators
    @prob.
          gsub('plus', '+').
          gsub('minus', '-').
          gsub('divided by', '/').
          gsub('multiplied by', '*')
  end
end

WordProblem.new('What is 5 plus 4?').answer  # => 9
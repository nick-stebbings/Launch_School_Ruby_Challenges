#
# P:
# Write a program that computes Pascal's triangle up to a given number of rows.
#
# In Pascal's Triangle each number is computed by adding the numbers to the right and left of the current position in the previous row.
#
#     1
#    1 1
#   1 2 1
#  1 3 3 1
# 1 4 6 4 1
# ... etc
# E:
#
# D:
#   Input = int
#   Output = 2d array, one inner array for each row
#
# A:
#    -if rows is 1, return [[1]]
#    -if rows is 2, return [[1], [1 1]]
#    - else recurse:
#     - [1] + (something) + [1]
#     -
#     -
#     -
#
# C:
#
require 'pry'
require_relative 'memoizer_module'

class Triangle
  include RubyMemoized

  def initialize(total_rows)
    @total_rows = total_rows
  end

  def rows
    triangle = [[1], [1, 1]]
    return [triangle[0]] if @total_rows == 1
    return triangle if @total_rows == 2

    1.upto(@total_rows - 2) do |row_idx|
      row = [1]
      row_el = 1
      row_size = row_idx
      while row_el < row_size + 1
        prev_row = triangle[row_idx]
        row << (prev_row[row_el - 1] + prev_row[row_el])
        row_el += 1
      end
      row << 1
      triangle << row
    end
    triangle
  end

  memoized

  def memoized_rows_recursive(rows)
    return [[1]] if rows == 1
    return [[1], [1, 1]] if rows == 2

    results = memoized_rows_recursive(rows - 1)
    middle_values = results
                    .last
                    .each_cons(2)
                    .with_object([]) { |pair, arr| arr << pair.sum }

    results << ([1] + middle_values + [1])
  end

  def rows_recursive(rows)
    return [[1]] if rows == 1
    return [[1], [1, 1]] if rows == 2

    results = rows_recursive(rows - 1)
    middle_values = results
                    .last
                    .each_cons(2)
                    .with_object([]) { |pair, arr| arr << pair.sum }

    results << ([1] + middle_values + [1])
  end

  def fib_recursive(n)
    return 1 if n == 1
    return 1 if n == 2

    fib_recursive(n - 1) + fib_recursive(n - 2)
  end

  def memoized_fib_recursive(n)
    return 1 if n == 1
    return 1 if n == 2

    fib_recursive(n - 1) + fib_recursive(n - 2)
  end

  # def memoise(&block)
  #   cache = {}
  #   if cache.keys.include?(@total_rows)
  #     return cache[@total_rows]
  #   else
  #     cache[@total_rows] = block.call
  #   end

  #   block
  # end
end

t = Triangle.new(10)

def execution_duration
  now = Time.now
  yield if block_given?
  puts (Time.now - now).to_s
end

execution_duration { t.rows_recursive(1000) }
execution_duration { t.memoized_rows_recursive(1000) }
binding.pry
# p t.rows_recursive(100)

# recurse_once = proc do |a, b|
#   a + b
# end
# p t.memoise { |num1, num2| recurse_once.call(num1, num2) }

# square = proc { |x| x**2 }

# square.call(3) #=> 9
# # shorthands:
# square.call(3) #=> 9
# square[3] #=> 9

# # Proc objects are closures, meaning they remember and can use the entire context in which they were created.

# def gen_times(factor)
#   proc { |n| n * factor } # remembers the value of factor at the moment of creation
# end

# times3 = gen_times(3)
# times5 = gen_times(5)

# times3.call(12)               #=> 36
# times5.call(5)                #=> 25
# times3.call(times5.call(4))   #=> 60

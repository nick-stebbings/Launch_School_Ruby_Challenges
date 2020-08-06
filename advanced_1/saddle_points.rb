=begin 
P:
Write a program that detects saddle points in a matrix.

So say you have a matrix like so:

    0  1  2
  |---------
0 | 9  8  7
1 | 5  3  2     <--- saddle point at (1,0)
2 | 6  6  7

It has a saddle point at (1, 0).

It's called a "saddle point" because it is greater than or equal to every element in its row and the less than or equal to every element in its column.

A matrix may have zero or more saddle points.

Your code should be able to provide the (possibly empty) list of all the saddle points for any given matrix.

Note that you may find other definitions of matrix saddle points online, but the tests for this exercise follow the above unambiguous definition.
E:

D:
  Input = string
  Output = array of indices (array with two elements)

A:
   - set a results array
   - split the input string by newlines to create rows
   - split each row on space
   - traverse the rows until you find the maximum in the row
   - for each maximum, traverse the intersecting column 
     - find the intersecting column by
   - if it is greater than all, add the coords to the results array
   -return results
   -

C:

=end

class Matrix
  def initialize(str)
    @input = str
  end

  def rows
    @input.split("\n").map { |row| row.split.map(&:to_i) }
  end

  def columns
    rows.transpose
  end

  def max_values
    rows.map do |row|
      row_max = row.max
      row.map { |num| num == row_max }
    end
  end

  def saddle_points
    columns
      .each_with_index
      .with_object([]) do |(column, col_idx), result|
        column.each_with_index do |num, idx|
          next unless num == column.min
          intersecting_row = max_values[idx]
          result << [idx, col_idx] if intersecting_row[col_idx]
        end
      end
  end
end

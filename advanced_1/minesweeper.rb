=begin 
P:
Minesweeper is a popular game where the user has to find the mines using numeric hints that indicate how many mines are directly adjacent (horizontally, vertically, diagonally) to a square.

In this exercise you have to create some code that counts the number of mines adjacent to a square and transforms boards like this (where * indicates a mine):

+-----+
| * * |
|  *  |
|  *  |
|     |
+-----+

into this:

+-----+
|1*3*1|
|13*31|
| 2*2 |
| 111 |
+-----+

- Implicit rules: Every row should be the same length
-                 Every middle row should start and end with /
-                 First and last rows will be +--..--+
                  Need to count the number of asterisks that are adjacent to a square
                  This includes diagonals
                  We do not need to map a square if it doesn't have an adjacent mine

D:
  Input = array of strings
  Output = array of strings, mapped to numerical values

A:
   - raise valueerror if
    - all rows not same length
    - middle rows not consisting of set of chars [* |]
    - edge rows not consisting of set of chars [+-]

   -/ make a 2d array of the game squares
   - map the split string rows
   - FOREACH square, count the number of *'s in its surrounding coords
    - idx-1, idx+1 in current row
    - row_idx-1,idx
    - row_idx+1,idx
  - IF the result is 0, map to space
  - ELSE map to the count
C:

=end
class ValueError < StandardError; end

class Board
  def self.transform(board_strings)
    new(board_strings).output
  end

  def initialize(input)
    raise ValueError.new unless valid_board(input) && same_length_rows?(input)

    @edge_col = input[0]
    @board_squares = input
                     .join('')
                     .split(/\|+/)[1..-2]
    @width = board_squares[0].size
    @height = board_squares.size
  end

  def output
    [edge_col, *mapped_squares, edge_col]
  end

  private

  attr_reader :board_squares, :edge_col

  def valid_board(board_strings)
    board_strings &&
      valid_rows(board_strings[1..-2], :middle) &&
      valid_rows([board_strings[0]] + [board_strings[-1]], :edge)
  end

  def mapped_squares
    board_squares.map.with_index do |row, row_idx|
      mapped_row = row.split('').map.with_index do |square, col_idx|
        next square if square == '*'

        mines_num = calculate_adjacent_mines(row, row_idx, col_idx)
        mines_num.positive? ? mines_num.to_s : ' '
      end
      "|#{mapped_row.join('')}|"
    end
  end

  def calculate_adjacent_mines(row, row_idx, col_idx)
    column_range = board_boundary_index(col_idx - 1, :col)..board_boundary_index(col_idx + 1, :col)
    [
      row_idx.zero? ? '' : mines_in_row(row_idx - 1, column_range),
      last_row?(row_idx) ? '' : mines_in_row(row_idx + 1, column_range),
      row[column_range.begin],
      row[column_range.end]
    ].join.count('*')
  end

  def mines_in_row(row_idx, cols_to_count)
    concat_mines_in_row(
      board_squares[board_boundary_index(row_idx, :row)],
      cols_to_count
    )
  end

  def concat_mines_in_row(board_row, column_range)
    board_row[column_range].gsub(/\s/, '')
  end

  def board_boundary_index(index, index_type)
    index.negative? ? 0 :
      if index_type == :col then [index, @width - 1].min
      elsif index_type == :row then [index, @height - 1].min
      end
  end

  def last_row?(row_idx)
    @height - 1 == row_idx
  end

  def same_length_rows?(board_strings)
    board_strings.group_by(&:length).size == 1
  end

  def valid_rows(board_strings, row_type)
    if row_type == :middle
      board_strings.join('').match?(/^[* |]*$/)
    elsif row_type == :edge
      board_strings.all? { |row| row.match?(/^\+\-*\+$/) }
    end
  end
end

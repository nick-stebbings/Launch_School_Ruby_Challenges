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

class ValueError < StandardError; end;

class Board
  class << self
    def transform(board_strings)
      raise ValueError.new unless (same_length_rows(board_strings) && valid_rows(board_strings[1..-2], :middle) && valid_rows([board_strings[0]] + [board_strings[-1]], :edge))
      @width = board_strings[0].size - 2
      board_squares = board_strings.join('').split(/\|+/)[1..-2]
      @height = board_squares.size

      [board_strings[0]] + map_squares(board_squares) + [board_strings[0]]
    end
  
    private
    
    def map_squares(board_squares)
      board_squares.map.with_index do |row, row_idx|
        mapped_row = row.split('').map.with_index do |sq, col_idx|
          next sq if sq == '*'
          mines_adjacent = ''

          mines_adjacent << row[col_idx - 1] if (row[col_idx - 1] == '*')
          mines_adjacent << row[col_idx + 1] if (row[col_idx + 1] == '*')
          
          lowest_col = col_idx == 0 ? 0 : (col_idx - 1)
          highest_col = col_idx == (@width - 1) ? -1 : (col_idx + 1)
          mines_adjacent << (row_idx.zero? ? '' : board_squares[row_idx - 1][lowest_col..highest_col].gsub(/\s/, ''))
          mines_adjacent << ((row_idx == @height - 1 ) ? '' : board_squares[row_idx + 1][lowest_col..highest_col].gsub(/\s/, ''))

          mines = mines_adjacent.count('*')
          mines > 0 ? mines.to_s : ' '
        end
        '|' + mapped_row.join('') + '|'
      end
    end
    
    def same_length_rows(board_strings)
      board_strings.group_by{ |row| row.length }.size == 1
    end
    
    def valid_rows(board_strings, row_type)
      if (row_type == :middle)
        board_strings.join('').match? /^[* |]*$/
      elsif (row_type == :edge)
        board_strings.all?{ |row| row.match? /^\+\-*\+$/ }
      end
    end
  end
end

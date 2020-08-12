=begin 
P:
In the game of chess, a queen can attack pieces which are on the same row, column, or diagonal.

A chessboard can be represented by an 8 by 8 array.

So if you're told the white queen is at (2, 3) and the black queen at (5, 6), then you'd know you've got a set-up like so:

_ _ _ _ _ _ _ _
_ _ _ _ _ _ _ _
_ _ _ W _ _ _ _
_ _ _ _ _ _ _ _
_ _ _ _ _ _ _ _
_ _ _ _ _ _ B _
_ _ _ _ _ _ _ _
_ _ _ _ _ _ _ _

You'd also be able to answer whether the queens can attack each other. In this case, that answer would be yes, they can, because both pieces share a diagonal.

Implicit:
 A queen can attack any square on the same row, column, or diagonal
 Can calculate diagonal attack by subtracting the x, y coords from each other and checking if they're equal

Explicit:
  a string version of the DS being used should be returned,
   - Underscores for each blank square, separate columns with spaces, rows with newlines
  CAN be represented by 8x8 array. This is the logical option then

E:

D:
  Input = positions of the two queens, coord arrays
  Output =  #to_s should return a string representation of the board
            #attack? - bool
A:
   - After testing valid inputs, instantiate a new board as 8 arrays of 8 elements.
    - If you do this with for loops you can add elements to represent queens by checking against row/column indices
   
#attack?
   -
   -
   -
   -

C:

=end
class Queens
  attr_reader :black, :white
  
  def initialize(white: [0, 3], black: [7, 3])
    raise ArgumentError if white == black
    @white = white
    @black = black
    @board = generate_board
  end

  def attack?
    white[0] == black[0] || white[1] == black[1] || ((white[0] - black[0]).abs == (white[1] - black[1]).abs)
  end
  
  def to_s
    board.map{ |row| row.join(' ') }.join("\n")
  end

  private
  attr_reader :board
  
  def generate_board
    row = Array.new(8) { '_' }
    Array.new(8) { row.dup }.map.with_index do |r, idx|
      r[white[1]] = 'W' if idx == white[0]
      r[black[1]] = 'B' if idx == black[0]
      r
    end
  end
end
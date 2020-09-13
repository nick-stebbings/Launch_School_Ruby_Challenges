# The kindergarten class is learning about growing plants. The teachers thought it would be a good idea to give them actual seeds, plant them in actual dirt, and grow actual plants.

# They've chosen to grow grass, clover, radishes, and violets.

# To this end, they've put little styrofoam cups along the window sills, and planted one type of plant in each cup, choosing randomly from the available types of seeds.

# [window][window][window]
# ........................ # each dot represents a styrofoam cup
# ........................

# There are 12 children in the class:

#     Alice, Bob, Charlie, David,
#     Eve, Fred, Ginny, Harriet,
#     Ileana, Joseph, Kincaid, and Larry.

# Each child gets 4 cups, two on each row. The children are assigned to cups in alphabetical order.

# The following diagram represents Alice's plants:

# [window][window][window]
# VR......................
# RG......................

# So in the row nearest the window, she has a violet and a radish; in the row behind that, she has a radish and some grass.

# Your program will be given the plants from left-to-right starting with the row nearest the windows. From this, it should be able to determine which plants belong to which students.

# For example, if it's told that the garden looks like so:

# [window][window][window]
# VRCGVVRVCGGCCGVRGCVCGCGV
# VRCCCGCRRGVCGCRVVCVGCGCV

# Then if asked for Alice's plants, it should provide:

#     Violets, radishes, violets, radishes

# While asking for Bob's plants would yield:

#     Clover, grass, clover, clover
=begin 
P:
Return the values for each of the children's plants.
There needs to be an attr_reader for each of the children:
Alice, Bob, Charlie, David,
    Eve, Fred, Ginny, Harriet,
    Ileana, Joseph, Kincaid, and Larry.


E:

D:
  Input =
  Output =

A:
Rules:

   - The plants string will be separated by new lines
   - Not all children will always have plants in the string
    - So we need only assign the arrays of plants to each child if they are included
   - The initialise method accepts an array of student names which will not always be ordered

   - Make instance variables or public methods for each of the names in the input array that needs to be included given the input string:
    - The number of names to take is equivalent to length of one of the lines of the input string divided by 2
   -
   -

C:

=end
class Garden
  attr_reader :students_squares
  STUDENTS = %w(Alice Bob Charlie David Eve Fred Ginny Harriet Ileana Joseph Kincaid Larry)
  
  def initialize(diagram, students_ary = STUDENTS)
    students_ary.sort!
    diagram
      .split("\n")
      .map{ |row| row.chars.each_slice(2).to_a }
      .reduce{ |result, row| result.zip(row) }
      .map(&:flatten)
      .take(students_ary.size)
      .each_with_index do |plant_square, student_index|
        self.class.send(:define_method, students_ary[student_index].downcase.to_sym) do
          plant_square.map do |plant|
            case plant
            when 'C' then :clover
            when 'G' then :grass
            when 'R' then :radishes
            when 'V' then :violets
            end
          end
        end
      end
  end
end

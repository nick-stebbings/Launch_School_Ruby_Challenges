=begin 
P:
A robot factory's test facility needs a program to verify robot movements.

The robots have three possible movements:

    turn right
    turn left
    advance

Robots are placed on a hypothetical infinite grid, facing a particular direction (north, east, south, or west) at a set of {x,y} coordinates, e.g., {3,8}, with coordinates increasing to the north and east.

The robot then receives a number of instructions, at which point the testing facility verifies the robot's new position, and in which direction it is pointing.

    The letter-string "RAALAL" means:
        Turn right
        Advance twice
        Turn left
        Advance once
        Turn left yet again

Say a robot starts at {7, 3} facing north. Then running this stream of instructions should leave it at {9, 4} facing west.
E:

D:
  Input =
  Output =

A:
   - .instructions:
   -  take a string,
   - separate it and map it to direction symbols, return the mapped hash
   - instructions[index of char in %w(L, R, A)]
   -

C:

=end

class Robot
  DIRECTIONS = [:east, :west, :north, :south]

  attr_reader :bearing, :coordinates

  def orient(direction)
    raise ArgumentError unless DIRECTIONS.include? direction
    @bearing = direction
  end

  def turn_right
    @bearing = case bearing
    when :east then :south
    when :west then :north
    when :north then :east
    else :west
    end
  end

  def turn_left
    @bearing = case bearing
    when :east then :north
    when :west then :south
    when :north then :west
    else :east
    end
  end

  def at(x, y); @coordinates = [x, y]; end

  def advance
    case @bearing
    when :east then @coordinates[0] += 1
    when :west then @coordinates[0] -= 1
    when :north then @coordinates[1] += 1
    when :south then @coordinates[1] -= 1
    end
  end
end

class Simulator
  INSTRUCTIONS = [:turn_right, :advance, :turn_left]

  def instructions(str)
    str.each_char.with_object([]) do |char, symbols|
      symbols << INSTRUCTIONS[%w(R A L).find_index(char)]
    end
  end

  def place(robot, x:, y:, direction:)
    robot.at(x, y)
    robot.orient(direction)
  end

  def evaluate(robot, instr)
    instructions(instr).each { |instr| robot.send(instr) }
  end
end
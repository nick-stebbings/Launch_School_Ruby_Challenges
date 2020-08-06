=begin 
P:
Write a program that manages robot factory settings.

When robots come off the factory floor, they have no name.The first time you boot them up, a random name is generated, such as RX837 or BC811.

Every once in a while we need to reset a robot to its factory settings, which means that their name gets wiped. The next time you ask, it will respond with a new random name.

The names must be random: they should not follow a predictable sequence. Random names means a risk of collisions. Your solution should not allow the use of the same name twice when avoidable.
E:

D:
  Input =
  Output =

A:
   -
   -
   -
   -
   -
   -

C:

=end

class Robot
  attr_reader :name
  def initialize(name)
    raise ArgumentError unless name.match? /^[A-Z]{2}\d{3}$/
    @name = generate(name)
  end

  def reset
    @name = generate(name)
  end

  def generate
    Kernel.srand
  end
end
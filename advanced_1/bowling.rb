=begin 
P:
Write code to keep track of the score of a game of bowling. It should support two operations:

    roll(pins) is called each time the player rolls a ball. The argument is the number of pins knocked down.

    score() is called only at the very end of the game. It returns the total score for that game.

    
    Rules:
    On the 10th or last frame a player will receive an extra roll each time they get all ten pins down to a maximum of three total rolls. Also on the last frame bonuses are not awarded for strikes and spares moving forward.

    If a player knocks down all pins in one strike they get 10 + the result of the next two bowls
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

class Game
  def initialize
    
  end

  def roll(pins)

  end

  def score

  end
end

  def roll_n_times(rolls, pins)
    rolls.times do
      Array(pins).each { |value| @game.roll(value) }
    end
  end
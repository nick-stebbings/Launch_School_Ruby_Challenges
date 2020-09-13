=begin 
P:
Write code to keep track of the score of a game of bowling. It should support two operations:

    roll(pins) is called each time the player rolls a ball. The argument is the number of pins knocked down.

    score() is called only at the very end of the game. It returns the total score for that game.

    
    Rules:
    On the 10th or last frame a player will receive an extra roll each time they get all ten pins down to a maximum of three total rolls. Also on the last frame bonuses are not awarded for strikes and spares moving forward.

    If a player knocks down all pins in one strike they get 10 + the result of the next two bowls
    If a player knocks down all pins in two they get 10 + the result of the next bowl
    
    There are 9 normal rounds per player then the final round where 3 rolls are possible and no bonuses awarded
    This means 18 normal rounds in a two player game

    If a player scores less than 10 in a normal round with both bowls, that is the total score for that round
    otherwise the results are dependent on the 1st(and maybe 2nd) bowls of the next round on rounds 1-9

    ergo we cannot necessarily compute the score of the 9th round until the final round has been scored
D:
  Input =
  Output =

A:
   - if we were to calculate in one function we could possibly use recursion using the base case as if it is the final round (pass n as rounds remaining). If n = 1, return an array of the values of the 3 strikes
   - else take the current round score.
        -  IF the second bowl is a spare return [x, 10-x] + element 0 from recurs(n-1)
        - IF the first bowl is a strike return [10] + elements 0,1 from recurs(n-1)
#roll        
- //if round != 0(the end) then raise 'Should not be able to roll after game is over'
   - enter the integer value into an array of scores for that round (push into a 2d array of pin values)
   - //keep an i.v. for which is the current player x
   - if the value is a 10, push it to player_x's pins array, then change player (unless fill_frame)
    - if the value will be the second value in player_x's current round score, push it and change player (unless fill_frame)
  =//  when you push to player 2, increment the round counter
  = when the round counter is 9, set fill_frame to true


#score
   //- if round != 0(the end) then raise 'Game is not yet over, cannot score!'
   -

C:

=end
class Player
  attr_accessor :score_card

  def initialize(name, scorecard = [])
    self.score_card = scorecard
    @name = name
  end

  def <<(bowls)
    score_card << bowls
  end
end

class Game
  attr_reader :player_1, :player_2, :current_player

  def initialize
    @round = 1
    @fill_frames = false
    @player_1 = Player.new('Player 1')
    @player_2 = Player.new('Player 2')
    @current_player = @player_1
    reset_turn_score
  end

  def roll(pins)
    raise StandardError.new('Should not be able to roll after game is over') if @round == 0
    if @round == 10
      @fill_frames = true
    end
    pins == 10 && @bowls_this_turn.empty? ? mark_score([10]) : (@bowls_this_turn << pins)
    if (@bowls_this_turn.size == 3 && @fill_frames) || (@bowls_this_turn.size == 2 && !@fill_frames)
      # what about 2 rolls in the fill frame?
      mark_score 
      reset_turn_score
      switch_player
      increment_round if @current_player == @player_1
    end
  end

  def score
    raise StandardError.new('Game is not yet over, cannot score!') unless @round == 0
    score_reduction(@player_1.score_card) + score_reduction(@player_2.score_card)
  end
  
  
  def score_reduction(rounds_array)
    #Algorithm:
    # You need to have a baseline as the final frame (fill frame
    # if final frame rules are: no bonuses, just count the frame and return.
    # if the recursive call above was wanting the next bowl, it will take it from the fill frame array
    # so we could just [0] of the recursive call to return ball 1, [0..1] if it was a strike
    # keep passing these conditionally back up to the frame above until you are at frame 1, then sum)
    return rounds_array if rounds_array.size == 1                     # => false
    last_round = rounds_array.shift  # =>
    if (last_round.sum == 10 && last_round.size == 1 )                  # => false
      return (last_round + score_reduction(rounds_array[0..1]) + score_reduction(rounds_array)  # => 
    elsif (last_round.sum == 10 && last_round.size == 2)                # => false
      return (last_round << score_reduction(rounds_array)[0]) + score_reduction(rounds_array)    # => 
    else                # => false
      return last_round + score_reduction(rounds_array)    # => 
    end                                                               # => 
  end
  private

  def reset_turn_score
    @bowls_this_turn = []
  end

  def increment_round
    @round = (@round == 10 ? 0 : @round + 1)
  end

  def switch_player
    @current_player = (@current_player == @player_1 ? @player_2 : @player_1)   # => 
  end

  def mark_score(bowls = @bowls_this_turn)
    @current_player << bowls  # => 
  end
end

  def roll_n_times(rolls, pins)
    rolls.times do
      Array(pins).each { |value| @game.roll(value) }
    end
  end
  @game =Game.new  # => #<Game:0x00007fffcfb33a18 @round=1, @fill_frames=false, @player_1=#<Player:0x00007fffcfb339c8 @score_card=[], @name="Player 1">, @player_2=#<Player:0x00007fffcfb33950 @score_card=[], @name="Player 2">, @current_player=#<Player:0x00007fffcfb339c8 @score_card=[], @name="Player 1">, @bowls_this_turn=[]>
  # @game.player_1 << 2 # => [2]
  @game.current_player  # => #<Player:0x00007fffcfb339c8 @score_card=[], @name="Player 1">
  p @game.score_reduction([[1,2], [1,2], [1,2], [4,4]])  # =>

MINUTES_IN_DAY = 1440

class Clock
  attr_reader :time

  def initialize(time)
    @time = time
  end

  def self.at(hour, mins = 0)
    Clock.new([hour, mins])
  end

  def to_s
    "%02d:%02d" % time
  end

  def ==(other)
    self.time == other.time
  end

  def to_minutes
    time[0] * 60 + time[1]
  end

  def +(mins)
    new_hrs, new_mins = ((to_minutes + mins) % MINUTES_IN_DAY).divmod(60)
    Clock.new([new_hrs, new_mins])
  end

  def -(mins)
    new_hrs, new_mins = ((to_minutes - mins) % MINUTES_IN_DAY).divmod(60)
    Clock.new([new_hrs, new_mins])
  end
end
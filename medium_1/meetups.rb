
# #     the first Monday
# #     the third Tuesday
# #     the Wednesteenth
# #     the last Thursday

# # Note that "Monteenth", "Tuesteenth", etc are all made up words. There was a meetup whose members realised that there are exactly 7 days that end in '-teenth'. Therefore, one is guaranteed that each day of the week (Monday, Tuesday, ...) will have exactly one date that is named with '-teenth' in every month.

# # Write code that calculates date of meetups.

# I: (to the new method), two integers representing a month and a year
# I: (to the date method), two symbols, the first representing the day of the week to be found,
# the second representing the qualifier for the specifice date. One of:
# :first,
# :second,
# :third,
# :fourth,
# :last
# :teenth,
# O: the Date object representing the correct day
# A: - require the date module,
#  - create initialize method
# needs to create a date object representing the first of the month in question


#  - create day method
# when it is called, need to select the appropriate day using the symbols as qualifiers
#        find the first in the month,
# CASE - when f, return it
        # - when s, t or f add the according amount
# CASE - when teenth SELECT days from that month where day = :day, date is between 13-19
# CASE - when last iterate back from end of month until day = :day
require 'date'

class Meetup
  def initialize(month, year)
    @first_of_month = Date.new(year, month, 1)
    @last_of_month = Date.new(year, month,-1)
  end

  def day(day_symbol, qualifier)
    all_of_weekday = @first_of_month.step(@last_of_month).select {|d| d.send(day_symbol.to_s + '?') }
    orders = [:first, :second, :third, :fourth]
      if (qualifier == :teenth)
        all_of_weekday.find{ |d| (13..19).cover?(d.mday) }
      elsif orders.include? qualifier
        all_of_weekday[orders.index(qualifier)]
      else
        all_of_weekday.last
      end
  end
end
# a = Meetup.new(3,2004)  # => #<Meetup:0x00007fffe4f45560 @first_of_month=#<Date: 2004-03-01 ((2453066j,0s,0n),+0s,2299161j)>, @last_of_month=#<Date: 2004-03-31 ((2453096j,0s,0n),+0s,2299161j)>>
# a.day(:monday, :teenth)  # => #<Date: 2004-03-01 ((2453066j,0s,0n),+0s,2299161j)>
# a.day(:tuesday, :third)  # => #<Date: 2004-03-16 ((2453081j,0s,0n),+0s,2299161j)>
# a.day(:friday, :last)  # => #<Date: 2004-03-26 ((2453091j,0s,0n),+0s,2299161j)>














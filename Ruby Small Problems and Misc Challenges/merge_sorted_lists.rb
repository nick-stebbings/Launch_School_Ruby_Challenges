#
# P:
# Write a method that takes two sorted Arrays as arguments, and returns a new Array that contains all elements from both arguments in sorted order.
#
# You may not provide any solution that requires you to sort the result array. You must build the result array one element at a time in the proper order.
#
# Your solution should not mutate the input arrays.
#
# D:
#   Input = two arrays
#   Output = new ary
#
# A:
#    - SET a new results ary
#    -  SET an ary2 counter to 0
#    - ITERATE through the first list
#     - FOREACH element in the list,
#      - WHILE el is greater than the ary2[ary2counter], push it to results ary, continue
#
#     - ELSE push ary2[ary2counter] of ary2 to results
#     -INCR ary2 counter
#    -
#    -
#
# C:
#
# def merge(ary1, ary2)
#   results = []
#   ary1_copy = ary1[0..-1]
#   ary2_copy = ary2[0..-1]
#   ary2_counter = 0

#   ary1.each do |ary1_el|
#     next_smallest_ary2_element = ary2[ary2_counter]
#     while next_smallest_ary2_element && (next_smallest_ary2_element < ary1_el)
#       results << next_smallest_ary2_element
#       ary2_counter += 1
#     end
#     results << ary1_el
#   end
#   results + ary2[ary2_counter..1]
# end

def merge(list1, list2)
  list1 = list1[0..-1]
  list2 = list2[0..-1]
  merged_ary = []

  while list1.size > 0 && list2.size > 0
    merged_ary << if list1[0] < list2[0]
                    list1.shift
                  else
                    list2.shift
                  end
  end
  merged_ary << list1.shift while list1.size > 0
  merged_ary << list2.shift while list2.size > 0
  merged_ary
end
p merge([1, 5, 9], [2, 6, 8]) == [1, 2, 5, 6, 8, 9]  # => true
p merge([1, 1, 3], [2, 2]) == [1, 1, 2, 2, 3]        # => true
p merge([], [1, 4, 5]) == [1, 4, 5]                  # => true
p merge([1, 4, 5], []) == [1, 4, 5]                  # => true
p merge([1, 4, 5, 9], []) == [1, 4, 5, 9] # => true

# >> [9]
# >> []
# >> true
# >> [3]
# >> []
# >> true
# >> []
# >> [1, 4, 5]
# >> true
# >> [1, 4, 5]
# >> []
# >> true
# >> [1, 4, 5, 9]
# >> []
# >> true

=begin 
Extra reading: https://www.geeksforgeeks.org/merge-sort/
                https://www.tutorialspoint.com/data_structures_algorithms/merge_sort_algorithm.htm
P:
Sort an array of passed in values using merge sort. You can assume that this array may contain only one type of data. And that data may be either all numbers or all strings.

Merge sort is a recursive sorting algorithm that works by breaking down the array elements into nested sub-arrays, then recombining those nested sub-arrays in sorted order. It is best shown by example. For instance, let's merge sort the array [9,5,7,1]. Breaking this down into nested sub-arrays, we get:

[9, 5, 7, 1] ->
[[9, 5], [7, 1]] ->
[[[9], [5]], [[7], [1]]]

We then work our way back to a flat array by merging each pair of nested sub-arrays:

[[[9], [5]], [[7], [1]]] ->
[[5, 9], [1, 7]] ->
[1, 5, 7, 9]

Examples:

merge_sort([9, 5, 7, 1]) == [1, 5, 7, 9]
merge_sort([5, 3]) == [3, 5]
merge_sort([6, 2, 7, 1, 4]) == [1, 2, 4, 6, 7]
merge_sort(%w(Sue Pete Alice Tyler Rachel Kim Bonnie)) == %w(Alice Bonnie Kim Pete Rachel Sue Tyler)
merge_sort([7, 3, 9, 15, 23, 1, 6, 51, 22, 37, 54, 43, 5, 25, 35, 18, 46]) == [1, 3, 5, 6, 7, 9, 15, 18, 22, 23, 25, 35, 37, 43, 46, 51, 54]

E:

  A: -- General outline:
    - Divide and conquer. Divide array into two halves, call the function  for both halves


C:
=end

def merge(list1, list2)
  # A  - SET a merged_ary var to []
  #    - WHILE length of a > 0 and length of b > 0
  #     - IF a[0] < b[0]
  #       - push onto merged_ary (b.shift), (a.shift)
  #       - ELSE
  #       - push onto merged_ary (b.shift), (a.shift)

  #   - Now push the remaining (odd elements) from a and b
  #     - WHILE length of a > 0,
  #      - merged_ary << (a.shift)
  #     - WHILE length of b > 0,
  #      - merged_ary << (b.shift)

  # - RETURN merged_ary
end


def merge_sort(ary)
  # - BASELINE/BREAK CONDITION: Length of input ary is 1
  # - THEN: return the ary
  # - ELSE divide list...

  #   - CALCULATE the middle point m 
  #       = Rule: If not an even split make the first half bigger.
  #       - m = ceiling(length of ary / 2)

  #   - SET first half = ary[0...m]
  #   - SET second half = ary[m..-1]
  #   - call #merge_sort on both halves
  #   - #merge the result of both method calls


end


p merge_sort([9, 5, 7, 1]) == [1, 5, 7, 9]
p merge_sort([5, 3]) == [3, 5]
p merge_sort([6, 2, 7, 1, 4]) == [1, 2, 4, 6, 7]
p merge_sort(%w(Sue Pete Alice Tyler Rachel Kim Bonnie)) == %w(Alice Bonnie Kim Pete Rachel Sue Tyler)
p merge_sort([7, 3, 9, 15, 23, 1, 6, 51, 22, 37, 54, 43, 5, 25, 35, 18, 46]) == [1, 3, 5, 6, 7, 9, 15, 18, 22, 23, 25, 35, 37, 43, 46, 51, 54]

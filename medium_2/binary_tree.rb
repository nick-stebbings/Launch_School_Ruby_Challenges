#
# P:
# Write a program that inserts numbers and searches in a binary tree.
#
# When we need to represent sorted data, an array does not make a good data structure.
#
# Say we have the array [1, 3, 4, 5], and we add 2 to it so it becomes [1, 3, 4, 5, 2] now we must sort the entire array again! We can improve on this by realizing that we only need to make space for the new item [1, nil, 3, 4, 5], and then adding the item in the space we added. But this still requires us to shift many elements down by one.
#
# Binary Search Trees, however, can operate on sorted data much more efficiently.
#
# A binary search tree consists of a series of connected nodes. Each node contains a piece of data (e.g. the number 3), a variable named left, and a variable named right. The left and right variables point at nil, or other nodes. Since these other nodes in turn have other nodes beneath them, we say that the left and right variables are pointing at subtrees. All data in the left subtree is less than or equal to the current node's data, and all data in the right subtree is greater than the current node's data.
#
# For example, if we had a node containing the data 4, and we added the data 2, our tree would look like this:
#
#   4
#  /
# 2
#
# If we then added 6, it would look like this:
#
#   4
#  / \
# 2   6
#
# If we then added 3, it would look like this
#
#    4
#  /   \
# 2     6
#  \
#   3
#
# And if we then added 1, 5, and 7, it would look like this
#
#       4
#     /   \
#    /     \
#   2       6
#  / \     / \
# 1   3   5   7
#
# Rules: implicit - there are no repeated node values

# D:
#   Input =
#   Output =
#
# A:
#    - Create a struct class for each node. It should have 3 pointers, left right and data
#    - If an item is being inserted
#      - THEN iterate through the tree, comparing each node
#            seeing if it's greater or less
#      - IF less then iterate through the left node \\
#      - else iterate through the left node \\

#        - WHILE struct's next node is nil AND current value > input, node = next.node

#  - Needs an 'each' method so it is iterable, starting from lowest value,
# - return an emuerator if no block is passed
 # -each needs to yield all nodes from smallest to greatest.

 # TRAVERSING UP IN VALUE:
 #  - At lowest node, 
 #  - Go to parent node,
 #    - Has right value? 
# C:
#
require 'pry'

Node = Struct.new(:data, :left, :right) do
  def insert(new_data)    
    current_node = self
      if new_data > current_node.data
        current_node.right.nil? ? (return current_node.right = Node.new(new_data, nil, nil)) : current_node.right.insert(new_data)
      else
        current_node.left.nil? ? (return current_node.left = Node.new(new_data, nil, nil)) : current_node.left.insert(new_data)
      end
  end
end

class Bst

  def initialize(num); @root_node = Node.new(num, nil, nil); @enum = Object.new.to_enum; end

  def data ; @root_node.data; end

  def left; @root_node.left; end

  def right; @root_node.right; end

  def insert(new_data); @root_node.insert(new_data); end

  def traverse_to_min
    current_node = @root_node
    while current_node.left
      current_node current_node.left
    end
    current_node
  end
  
  def is_left_edge?(node)
    node.left.nil?
  end

  def is_right_edge?(node)
    node.right.nil?
  end
  
  def @enum.each
    yield
  end

  def each(node = @root_node, enum = @enum, &block)
    # Algo: In order traversal, check LEFT then DATA then RIGHT
    # So to do this recursively, we need to recurse over left subtree
    # THEN yield the current node's data
    # THEN recurs over the right subtree
    # Break condition: if left.nil? and right.nil? you are at an edge node, return
    return if node.nil?
    begin
      each(node.left, &block)
      block.call(node.data) if block_given?
      enum.feed(node.data) # ~> TypeError: feed value already set
      each(node.right, &block)
    rescue StopIteration
      return enum
    end
    return enum
  end
end

    four = Bst.new 4  # => #<Bst:0x00007fffd5df1470 @root_node=#<struct Node data=4, left=nil, right=nil>, @enum=#<Enumerator: #<Object:0x00007fffd5df13f8>:each>>
    four.insert 2     # => #<struct Node data=2, left=nil, right=nil>
    four.insert 6     # => #<struct Node data=6, left=nil, right=nil>
    four.insert 1     # => #<struct Node data=1, left=nil, right=nil>
    four.insert 3     # => #<struct Node data=3, left=nil, right=nil>
    four.insert 7     # => #<struct Node data=7, left=nil, right=nil>
    four.insert 5     # => #<struct Node data=5, left=nil, right=nil>
    four  # => #<Bst:0x00007fffd5df1470 @root_node=#<struct Node data=4, left=#<struct Node data=2, left=#<struct Node data=1, left=nil, right=nil>, right=#<struct Node data=3, left=nil, right=nil>>, right=#<struct Node data=6, left=#<struct Node data=5, left=nil, right=nil>, right=#<struct Node data=7, left=nil, right=nil>>>, @enum=#<Enumerator: #<Object:0x00007fffd5df13f8>:each>>
  def record_all_data(bst)
    all_data = []
    bst.each { |data| all_data << data }
    all_data
  end
      tree = Bst.new 4
    [2, 1, 3, 6, 7, 5].each { |x| tree.insert x }  # => [2, 1, 3, 6, 7, 5]
    each_enumerator = tree.each  # => 
    each_enumerator.next  # => 

# ~> TypeError
# ~> feed value already set
# ~>
# ~> binary_tree.rb:123:in `feed'
# ~> binary_tree.rb:123:in `each'
# ~> binary_tree.rb:121:in `each'
# ~> binary_tree.rb:147:in `<main>'
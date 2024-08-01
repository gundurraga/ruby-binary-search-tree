require_relative 'tree'

# 1. Create a binary search tree from an array of random numbers
array = Array.new(15) { rand(1..100) }
tree = Tree.new(array)

# 2. Confirm that the tree is balanced
puts "Is the tree balanced? #{tree.balanced?}"

# 3. Print out all elements in level, pre, post, and in order
puts "\nLevel order traversal:"
p tree.level_order

puts "\nPreorder traversal:"
p tree.preorder

puts "\nPostorder traversal:"
p tree.postorder

puts "\nInorder traversal:"
p tree.inorder

# 4. Unbalance the tree by adding several numbers > 100
puts "\nAdding numbers to unbalance the tree..."
tree.insert(101)
tree.insert(102)
tree.insert(103)
tree.insert(104)
tree.insert(105)

# 5. Confirm that the tree is unbalanced
puts "Is the tree balanced? #{tree.balanced?}"

# 6. Balance the tree by calling #rebalance
puts "\nRebalancing the tree..."
tree.rebalance

# 7. Confirm that the tree is balanced
puts "Is the tree balanced? #{tree.balanced?}"

# 8. Print out all elements in level, pre, post, and in order
puts "\nLevel order traversal:"
p tree.level_order

puts "\nPreorder traversal:"
p tree.preorder

puts "\nPostorder traversal:"
p tree.postorder

puts "\nInorder traversal:"
p tree.inorder

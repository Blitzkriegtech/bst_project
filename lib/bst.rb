# frozen_string_literal: true

# A Node represents a single element in the Binary Search Tree (BST)
# Each node stores:
# - data: the value it holds
# - left: pointer to left child (smaller values)
# - right: pointer to right child (larger values)
class Node
  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil # Starts with no children
    @right = nil
  end
end

# A Binary Search Tree (BST) where:
# - Left subtree contains only values less than the root
# - Right subtree contains only values greater than the root
# - Each subtree is also a BST
class Tree
  attr_reader :root # Expose root for testing/visualization

  # Initialize BST with sorted, unique values from array
  def initialize(array)
    @root = build_tree(array.uniq.sort)
  end

  # Builds balanced tree from sorted array
  def build_tree(sorted_array)
    return nil if sorted_array.empty? # Base case: empty array

    # Find middle element to make balanced tree
    mid_index = sorted_array.length / 2
    root_node = Node.new(sorted_array[mid_index])

    # Recursively build left and right subtrees
    root_node.left = build_tree(sorted_array[0...mid_index])
    root_node.right = build_tree(sorted_array[mid_index + 1..-1])

    root_node
  end

  # Insert new value in BST
  def insert(value, node = @root)
    return Node.new(value) if node.nil? # Found empty spot, create node

    if value < node.data
      node.left = insert(value, node.left) # Go left if smaller
    elsif value > node.data
      node.right = insert(value, node.right) # Go right if larger
    end
    node # Return unchanged node if duplicate
  end

  # Delete value from BST (3 cases)
  def delete(value, node = @root)
    return nil if node.nil? # Value not found

    if value < node.data
      node.left = delete(value, node.left) # Search left
    elsif value > node.data
      node.right = delete(value, node.right) # Search right
    else
      # Case 1: No children or one child
      return node.right if node.left.nil?
      return node.left if node.right.nil?

      # Case 2: Two children
      # Find smallest value in right subtree (successor)
      successor = find_min(node.right)
      node.data = successor.data # Copy successor's value
      node.right = delete(successor.data, node.right) # Remove original successor
    end
    node
  end

  # Find node with minimum value (leftmost node)
  def find_min(node = @root)
    node.left ? find_min(node.left) : node
  end

  # Find node with specific value
  def find(value, node = @root)
    return nil if node.nil?
    return node if node.data == value

    value < node.data ? find(value, node.left) : find(value, node.right)
  end

  # Breadth-First Search (Level Order)
  def level_order
    return [] if @root.nil?

    queue = [@root]
    result = []

    until queue.empty?
      current = queue.shift
      result << current.data
      queue << current.left if current.left
      queue << current.right if current.right
    end
    result
  end

  # Depth-First Search: Left -> Root -> Right (sorted order)
  def inorder(node = @root, result = [])
    return result if node.nil?

    inorder(node.left, result)
    result << node.data
    inorder(node.right, result)
    result
  end

  # Depth-First Search: Root -> Left -> Right
  def preorder(node = @root, result = [])
    return result if node.nil?

    result << node.data
    preorder(node.left, result)
    preorder(node.right, result)
    result
  end

  # Depth-First Search: Left -> Right -> Root
  def postorder(node = @root, result = [])
    return result if node.nil?

    postorder(node.left, result)
    postorder(node.right, result)
    result << node.data
    result
  end

  # Height: Longest path from node to leaf
  def height(node = @root)
    return -1 if node.nil? # Base case: empty tree has height -1

    left_height = height(node.left)
    right_height = height(node.right)
    1 + [left_height, right_height].max
  end

  # Depth: Path length from root to node
  def depth(target_node)
    current = @root
    depth = 0

    while current && current != target_node
      depth += 1
      current = target_node.data < current.data ? current.left : current.right
    end
    current ? depth : nil # Return nil if node not found
  end

  # Check if tree is balanced (height difference <= 1 in all subtrees)
  def balanced?(node = @root)
    return true if node.nil? # Empty tree is balanced

    left_height = height(node.left)
    right_height = height(node.right)

    (left_height - right_height).abs <= 1 &&
      balanced?(node.left) &&
      balanced?(node.right)
  end

  # Rebuild tree to balance it
  def rebalance
    @root = build_tree(inorder)
  end
end

# Generate an array of 15 random numbers between 1 and 100.
array = Array.new(15) { rand(1..100) }
# Create a new tree instance using the generated array.
tree = Tree.new(array)

# Output whether the initially built tree is balanced.
puts "Initial tree balanced? #{tree.balanced?}"
# Display the tree's elements in different traversal orders.
puts "Level order: #{tree.level_order}"
puts "Preorder: #{tree.preorder}"
puts "Postorder: #{tree.postorder}"
puts "Inorder: #{tree.inorder}"

# Insert 5 new random values between 101 and 200 to likely unbalance the tree.
5.times { tree.insert(rand(101..200)) }
puts "\nTree balanced after additions? #{tree.balanced?}"

# Rebalance the tree.
tree.rebalance
puts "\nTree balanced after rebalancing? #{tree.balanced?}"
# Output the traversal orders of the rebalanced tree.
puts "Level order: #{tree.level_order}"
puts "Preorder: #{tree.preorder}"
puts "Postorder: #{tree.postorder}"
puts "Inorder: #{tree.inorder}"

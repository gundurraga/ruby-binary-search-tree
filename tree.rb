require_relative 'node'

class Tree
  attr_accessor :root

  def initialize(array)
    @root = build_tree(array)
  end

  def insert(value)
    @root = insert_recursive(@root, value)
  end

  def delete(value)
    @root = delete_recursive(@root, value)
  end

  def find(value)
    find_recursive(@root, value)
  end

  def height(node = @root)
    return -1 if node.nil?

    left_height = height(node.left)
    right_height = height(node.right)

    [left_height, right_height].max + 1
  end

  def depth(node)
    return nil if node.nil?
    return 0 if node == @root

    depth = 0
    current = @root

    while current != node
      if node.data < current.data
        current = current.left
      elsif node.data > current.data
        current = current.right
      else
        break # Node found
      end
      depth += 1
      return nil if current.nil? # Node not in the tree
    end

    depth
  end

  def balanced?
    balanced_recursive?(@root)
  end

  def level_order
    return [] if @root.nil?

    queue = [@root]
    result = []

    until queue.empty?
      node = queue.shift
      block_given? ? yield(node) : result << node.data
      queue << node.left if node.left
      queue << node.right if node.right
    end

    result unless block_given?
  end

  def inorder(&block)
    inorder_recursive(@root, [], &block)
  end

  def preorder(&block)
    preorder_recursive(@root, [], &block)
  end

  def postorder(&block)
    postorder_recursive(@root, [], &block)
  end

  def rebalance
    values = inorder
    @root = build_tree(values)
  end

  private

  def balanced_recursive?(node)
    return true if node.nil?

    left_height = height(node.left)
    right_height = height(node.right)

    return false if (left_height - right_height).abs > 1

    balanced_recursive?(node.left) && balanced_recursive?(node.right)
  end

  def build_tree(array)
    return nil if array.empty?

    array = array.uniq.sort

    mid = array.length / 2

    node = Node.new(array[mid])

    # Recursively build left and right subtrees
    node.left = build_tree(array[0...mid])
    node.right = build_tree(array[(mid + 1)..])

    node
  end

  def insert_recursive(node, value)
    return Node.new(value) if node.nil?

    if value < node.data
      node.left = insert_recursive(node.left, value)
    elsif value > node.data
      node.right = insert_recursive(node.right, value)
    end

    node
  end

  def delete_recursive(node, value)
    return nil if node.nil?

    if value < node.data
      node.left = delete_recursive(node.left, value)
    elsif value > node.data
      node.right = delete_recursive(node.right, value)
    else
      # Node to delete found

      # Case 1: Leaf node
      return nil if node.left.nil? && node.right.nil?

      # Case 2: Node with only one child
      return node.left if node.right.nil?
      return node.right if node.left.nil?

      # Case 3: Node with two children
      leftmost = find_leftmost(node.right)
      node.data = leftmost.data
      node.right = delete_recursive(node.right, leftmost.data)
    end

    node
  end

  def find_leftmost(node)
    node = node.left until node.left.nil?
    node
  end

  def find_recursive(node, value)
    return nil if node.nil?
    return node if node.data == value

    if value < node.data
      find_recursive(node.left, value)
    else
      find_recursive(node.right, value)
    end
  end

  def inorder_recursive(node, result, &block)
    return result if node.nil?

    inorder_recursive(node.left, result, &block)
    block_given? ? yield(node) : result << node.data
    inorder_recursive(node.right, result, &block)

    result
  end

  def preorder_recursive(node, result, &block)
    return result if node.nil?

    block_given? ? yield(node) : result << node.data
    preorder_recursive(node.left, result, &block)
    preorder_recursive(node.right, result, &block)

    result
  end

  def postorder_recursive(node, result, &block)
    return result if node.nil?

    postorder_recursive(node.left, result, &block)
    postorder_recursive(node.right, result, &block)
    block_given? ? yield(node) : result << node.data

    result
  end
end

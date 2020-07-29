class Node
  include Comparable
  attr_accessor :data, :left, :right

  def initialize(data, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
  end

  # if the comparable module is included, the insert method has to be 
  # rewritten for 1,0,-1 data traversing; 
  # currently its explicitly checking every node 
  #
  # def <=>(other)
  #   data <=> other.data
  # end
end

class Tree
  attr_accessor :root

  def initialize(array)
    @array = array.sort!
    @root = build_tree(@array)
  end

  def build_tree(array)
    #base case 
    if array.empty? 
      return nil
    else
      middle = array.length / 2

      node = Node.new(array[middle])
      #exclusive range 
      node.left = build_tree(array[0...middle])

      node.right = build_tree(array[middle+1..-1])

      return node
    end
  end

  def insert(value)
    node = @root
    
    #infinite loop but breaking out of it if node was added on left or right side
    loop do
      if value < node.data
        if node.left == nil
          node.left = Node.new(value)
          break 
        else
          node = node.left
        end
      elsif value > node.data
        if node.right == nil
          node.right = Node.new(value)
          break
        else
          node = node.right
        end
      end
    end
  end

  def delete(value)
    node = @root
    parent = @root

    #traverse tree and update parent and child until value == parent.data
    until value == node.data
      if value < node.data
        parent = node
        node = node.left
      elsif value > node.data
        parent = node
        node = node.right
      end
    end

    #delete if node has no children
    if node.left == nil && node.right == nil
      if parent.left == node
        parent.left = nil
      else
        parent.right = nil
      end
    #delete if node has two children 
    elsif node.left != nil && node.right != nil
      node = node.right
      parent = parent.right
      min = node.data
    
      #find lowest value in subtree
      while node.left != nil
        min = node.left.data
        node = node.left
      end

      parent.data = min

      parent.right = node.right
    #delete if node has one child
    elsif node.left != nil || node.right != nil
      if node.left != nil 
        parent.left = node.left
      else
        parent.right = node.right
      end
    end
  end

  def find(value)
    node = @root
  
    #does seem to work, who knows
    loop do
      if node.data == value
        return node
      elsif node.right == nil && node.left == nil
        return nil
      elsif value < node.data && node.left != nil
        node = node.left
      elsif value > node.data && node.right != nil
        node = node.right
      else
        return "Value not found"
      end
    end
  end

  def level_order
    node_values = []
    traverse_array = []
    node = @root
    
    traverse_array << node

    until traverse_array.empty?
      #shift first node out of traversing array
      node = traverse_array.shift

      node_values << node.data
      #add left node to queue, add right node to queue
      traverse_array << node.left if node.left != nil
      traverse_array << node.right if node.right != nil
    end

    return node_values
  end
  
  def inorder(node = @root, array = [])
    if node == nil
      return
    else
      left = inorder(node.left, array)
      array << node.data
      right = inorder(node.right, array)
    end
    return array
  end

  def preorder(node = @root, array = [])
    if node == nil 
      return
    else
      array << node.data
      left = preorder(node.left, array)
      right = preorder(node.right, array)
    end
    return array
  end

  def postorder(node = @root, array = [])
    if node == nil
      return
    else
      left = postorder(node.left, array)
      right = postorder(node.right, array)
      array << node.data
    end
    return array
  end

  def depth(node = @root)
    #recursive call on node an return the deepest node of left and right
    #side of tree, and adding +1 in every level 
    if node == nil
      return -1
    else
      return [depth(node.left), depth(node.right)].max + 1
    end
  end

  def balanced?
    node = @root

    if depth(node.left) > depth(node.right)
      return (depth(node.left) - depth(node.right)) <= 1 ? true : false
    else
      return (depth(node.right) - depth(node.left)) <= 1 ? true : false
    end
  end

  #display as tree
  def pretty_print(node = root, prefix="", is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? "│ " : " "}", false) if node.right
    puts "#{prefix}#{is_left ? "└── " : "┌── "}#{node.data.to_s}"
    pretty_print(node.left, "#{prefix}#{is_left ? " " : "│ "}", true) if node.left
  end
end

#test methods
a1 = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
a2 = [1, 2, 3, 5, 6]
p a2.length
t1 = Tree.new(a2)
p t1.root
t1.insert(4)
t1.insert(7)
t1.insert(8)
t1.insert(9)
p t1
t1.pretty_print
p t1.depth
p t1.balanced?
p t1.inorder
p t1.preorder
p t1.postorder
t1.delete(2)
t1.pretty_print
p t1.balanced?
t1.delete(6)
t1.pretty_print
t1.delete(7)
t1.pretty_print
t1.delete(8)
t1.pretty_print
t1.delete(5)
t1.pretty_print
p t1.find(1)
p t1.find(9)
p t1.find(33)
p t1.find(3)
puts "--------------------"
p t1.level_order
p t1.inorder
p t1.preorder
p t1.postorder
p t1.depth
p t1.balanced?
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
    #base case is not met => stackoverflow
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
    #check node for value 
    #if value <= root got left; if vlaue >= right go right if both 
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

  #wip
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
    #delete if node has two children => inorder?
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
t1.delete(2)
t1.pretty_print
t1.delete(6)
t1.pretty_print
t1.delete(7)
t1.pretty_print
t1.delete(8)
t1.pretty_print
t1.delete(5)
t1.pretty_print
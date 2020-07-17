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
    #if node left + right = nil => remove node
    # one child => copy the to previous child
    # two child => inorder succesor?
    node = @root
    parent = nil

    #traverse tree and update parent and child
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
    p parent
    puts ""
    p node
  end
end

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
t1.delete(1)

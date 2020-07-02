#node has data, next
#next node has data, next (head + tail)
#linked list contains all nodes; calls nodes
#TODO: refactor traversing into own function

class Node
  attr_accessor :value, :next_node

  def initialize(value = nil, next_node = nil)
    @value = value;
    @next_node = next_node
  end
end

class LinkedList
  def initialize
    @head = Node.new(0)
  end

  def append(value)
    if @head == nil
      #prepend item
    else
      temp = @head

      #traversing the node unitl next node is the last because last == nil
      while temp.next_node != nil
        temp = temp.next_node
      end

      temp.next_node = Node.new(value)
    end
  end

  #add value to start of the list
  def prepend(value)
    #im surprised this works => next node is previous @head before head is new #assigned
    @head = Node.new(value, @head)
  end

  def size
    temp = @head
    counter = 1

    while temp.next_node != nil
      temp = temp.next_node
      counter += 1
    end
    return counter
  end

  def at(index)
    temp = @head
    counter = 0

    while counter != index
      temp = temp.next_node
      counter += 1
    end
    return temp.value
  end

  def head
    @head.value
  end

  def tail
    temp = @head

    while temp.next_node != nil
      temp = temp.next_node
    end

    temp.value
  end
end

list = LinkedList.new()

i = 1
while i < 11
  list.append(i)
  i += 1
end

p list
puts "Size: #{list.size}"  
puts "Head: #{list.head}"  
puts "Tail: #{list.tail}"  
puts "Index 0 : #{list.at(0)}"
puts "Index 10 #{list.at(10)}"
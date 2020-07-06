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
      prepend(value)
    else
      current = @head

      while current.next_node != nil
        current = current.next_node
      end

      current.next_node = Node.new(value)
    end
  end

  def prepend(value)
    #the new Nodes.next_node is assigned @head before @head is reassigned
    @head = Node.new(value, @head)
  end

  def size
    current = @head
    counter = 1

    while current.next_node != nil
      current = current.next_node
      counter += 1
    end
    return counter
  end

  def at(index)
    current = @head
    counter = 0

    while counter != index
      current = current.next_node
      counter += 1
    end
    return current.value
  end

  def head
    @head.value
  end

  def tail
    current = @head

    while current.next_node != nil
      current = current.next_node
    end

    current.value
  end

  #its late and im suprised this seems to be working, error if list <2
  def pop
    if size == 1
      @head.next_node = nil
    else
      current = @head.next_node
      previous = @head

      while current.next_node != nil
        current = current.next_node 
        previous = previous.next_node
      end

      previous.next_node = nil
    end
  end

  def contains?(value)
    current = @head
    contains = false

    while current.next_node != nil
      if current.value == value
        contains = true
      end
      current = current.next_node
    end
    contains
  end

  def find(value)
    current = @head
    counter = 0

    while current.next_node != nil
      break if current.value == value
      current = current.next_node
      counter += 1
    end
    counter
  end

  def to_s
    current = @head
  
    until current.nil?
      print " ( #{current.value} ) ->"
      current = current.next_node
    end
    print " nil \n"
  end
end

list = LinkedList.new()

i = 1
while i < 11
  list.append(i)
  i += 1
end

list.to_s
puts "Size: #{list.size}"  
puts "Head: #{list.head}"  
puts "Tail: #{list.tail}"  
puts "At 0 : #{list.at(0)}"
puts "At 10 #{list.at(10)}"
p list.find(15)

j = 0
while j < 5
  list.pop
  j += 1
end
puts "#{list.size}"
p list
p list.contains?(1)
list.to_s

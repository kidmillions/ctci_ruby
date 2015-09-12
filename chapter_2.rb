# Implementing a linked list

class Node
  def initialize (data)
    @data = data
    @next = nil
  end

  attr_accessor :next
  attr_reader :data
end


class LinkedList

  def initialize
    @head = nil
    @tail = nil
  end

  def add_to_tail(value)
    node = Node.new(value)
    unless @tail == nil
      @tail.next = node
    else
      @head = node
    end
    @tail = node
  end

  def remove_from_head
    if @head
      tmp = @head
      @head = @head.next
      tmp.data
    else
      nil
    end
  end

  def size
    if @head
      cur_node = @head
      count = 1
      while cur_node.next != nil
        cur_node = cur_node.next
        count += 1
      end
      count
    else
      0
    end
  end

end

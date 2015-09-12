# Implementing a linked list
# 2.1 remove duplicates from unsorted Linked list


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

  def remove_duplicates!
    vals = Hash.new(false)
    if @head
      cur_node = @head

      while cur_node.next != nil
        if vals[cur_node.data]
          prev_node.next = cur_node.next
        else
          vals[cur_node.data] == true
        end
        prev_node = cur_node
        cur_node = cur_node.next
      end
    end

    self
  end


  def each
    c = @head
    until c == nil
      yield c
      c = c.next
    end
  end

  def remove_duplicates_with_runner!
    if @head
      cur_node = @head

      while cur_node != nil
        runner = cur_node
        while runner.next != nil
          if runner.next.data == cur_node.data
            runner.next = runner.next.next
          else
            runner = runner.next
          end
        end

        cur_node = cur_node.next
      end
    end

    self

  end



end

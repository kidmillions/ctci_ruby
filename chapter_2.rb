# Implementing a linked list
# 2.1 remove duplicates from unsorted Linked list
# 2.2 find the kth to last element in a singly linked list
# 2.3 delete a node

class Node
  def initialize (data)
    @data = data
    @next = nil
  end

  def delete
    unless @next == nil
      next_node = @next
      @data = next_node.data
      @next = next_node.next
      return true
    end
    return false
  end

  attr_accessor :next
  attr_reader :data
end


class LinkedList

  def initialize
    @head = nil
    @tail = nil
  end

  attr_reader :head, :tail

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
      count = 0
      while cur_node != nil
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
      prev_node = nil

      while cur_node != nil
        if vals[cur_node.data] == true
          puts "found dup"
          prev_node.next = cur_node.next
        else
          vals[cur_node.data] = true
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


  def nth_to_last (k)
    current_node = @head
    runner = @head

    k.times do
      runner = runner.next
    end

    while runner.next != nil
      runner = runner.next
      current_node = current_node.next
    end

    current_node.data


  end

  def partition (x)
    before = LinkedList.new
    after = LinkedList.new

    cur_node = @head
    while cur_node != nil
      if cur_node.data <= x
        before.add_to_tail(cur_node.data)
      else
        after.add_to_tail(cur_node.data)
      end
      cur_node = cur_node.next
    end

    before.tail.next = after.head

    before.head

  end

  def add (other_list)
      sum = LinkedList.new
      one_node = @head
      other_node = other_list.head
      leftover = 0

      while (one_node != nil && other_node != nil)
        sum.add_to_tail((one_node.data + other_node.data) % 10 + leftover)

        leftover = ((one_node.data.to_f + other_node.data.to_f) / 10).floor

        one_node = one_node.next
        other_node = other_node.next
      end

      if (one_node != nil)
        while (one_node != nil)
          sum.add_to_tail(one_node.data + leftover)
          leftover = 0
          one_node = one_node.next
        end
      elsif (other_node != nil)
        while (other_node != nil)
          sum.add_to_tail(other_node.data + leftover)
          leftover = 0
          other_node = other_node.next
        end
      end

      sum
  end


  


end

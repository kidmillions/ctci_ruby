# Implementing a stack
# 3.1 Implement 3 stacks with a single array
# 3.2 function min to return the min element
# 3.3 SetOfStacks adds a new stack once capacity is exceeded

class Node
  def initialize (data)
    @data = data
    @next = nil
  end

  attr_accessor :next
  attr_reader :data
end



class Stack
  def initialize
    @top = Node.new(nil)
    @min = []
  end

  def pop
    if (@top != nil)
      tmp = @top.data

      if (@min.last == tmp)
        @min.pop
      end

      @top = @top.next
      tmp
    end
  end

  def push(val)
    if (@min.length == 0 || @min.last > val)
      @min.push(val)
    end
    t = Node.new(val)
    t.next = @top
    @top = t

  end

  def peek
    @top
  end

  def show_min
    @min.last
  end

  def size
    cur_node = @top
    count = 0
    while cur_node != nil && cur_node.data != nil
      count += 1
      cur_node = cur_node.next
    end
    count
  end

end


class Queue
  def initialize
    @first = Node.new(nil)
    @last = Node.new(nil)
  end

  def enqueue(val)
    if (@first.data == nil)
      @last = Node.new(val)
      @first = @last
    else
      @last.next = Node.new(val)
      @last = @last.next
    end
  end

  def dequeue
    if (@first != nil)
      dequeued = @first.data
      @first = @first.next
      if (@first == nil)
        @last = nil
      end
      dequeued
    else
      nil
    end
  end

end

class StackForSet < Stack
 def initialize (capacity)
   @top = Node.new(nil)
   @min = []
   @capacity = capacity
   @next = nil
 end

 attr_accessor :next

 def is_full?

   puts size
   puts @capacity
   size == @capacity

 end

 def is_empty?
   size == 0
 end
end

class SetOfStacks
  def initialize (capacity)
    @top = StackForSet.new(capacity)
    @stack_capacity = capacity
  end

  def push (val)
    if (@top.is_full?)
      s = StackForSet.new(@stack_capacity)
      s.next = @top
      @top = s
    end

    @top.push(val)
  end

  def pop
    t = @top.pop
    if @top.is_empty?
      @top = @top.next
    end
    t
  end

  def size
    cur_stack = @top
    count = 0
    while cur_stack != nil
      count += 1
      cur_stack = cur_stack.next
    end
    count
  end


  def pop_at_index(idx)
    # note that this does not maintain stacks at capacity. See 'SetOfStacks#add_at_lowest_index'
    # to refill SetOfStacks to capacity
    if (idx == 0)
      return @top.pop
    end
    cur_stack = @top
    idx.times do
      cur_stack = cur_stack.next
    end
    return cur_stack.pop
  end

  # def self.collapse(idx = @top)
  #   cur_stack = @top
  #
  #   while cur_stack.next != nil
  #     cur_stack = cur_stack.next
  #   end
  #
  #   if cur_stack == @top
  #     return
  #   else
  #
  #
  #
  # end


end

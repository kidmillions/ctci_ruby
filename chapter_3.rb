# Implementing a stack
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
  end

  def pop
    if (@top != nil)
      tmp = @top.data
      @top = @top.next
      tmp
    end
  end

  def push(val)
    t = Node.new(val)
    t.next = @top
    @top = t
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

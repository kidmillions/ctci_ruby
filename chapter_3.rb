# Implementing a stack
# 3.1 Implement 3 stacks with a single array
# 3.2 function min to return the min element
# 3.3 SetOfStacks adds a new stack once capacity is exceeded
# 3.6 Sort a stack in ascending order

require('./chapter_2.rb')


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
    @top.data
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

  def is_empty?
    size == 0
  end

  def sort!
    buffer_stack = Stack.new
    while (!is_empty?)
      tmp = pop
      puts "checking value #{tmp}"
      while(tmp > buffer_stack.peek)
        puts "popping #{buffer_stack.peek} off the buffer to make way for #{tmp}"
        push(buffer_stack.pop)
      end
      puts "#{tmp} should be <= #{buffer_stack.peek}"
      buffer_stack.push(tmp)
    end


    while(!buffer_stack.is_empty?)
      push(buffer_stack.pop)
    end

    self

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




# Tower of Hanoi problem
class Tower
  def initialize(num_disks)
    @disks = Stack.new
    @index = num_disks
  end

  def index
    @index
  end

  def add(data)
    if (!@disks.is_empty? && @disks.peek <= data)
      puts "error placing disk #{data}"
    else
      @disks.push(data)
    end
  end

  def move_top_to(tower)
    t = @disks.pop
    tower.add(t)
    puts "Moved disk #{t} from #{index()} to #{tower.index()}"
  end

  def move_disks(num, destination, buffer)
     if (num > 0)
       move_disks(num - 1, buffer, destination)
       move_top_to(destination)
       buffer.move_disks(num - 1, destination, self)
     end
  end

end

def hanoi_tower(n)
  towers = []
  3.times do |i|
    towers.push(Tower.new(i))
  end

  n.times do |i|
    towers[0].add(n - i)
  end

  towers[0].move_disks(n, towers[2], towers[1])

end


# 3.5 myQueue class that implements queue with two stacks


class MyQueue
  def initialize
    @inbox = Stack.new
    @outbox = Stack.new
  end

  def size
    @inbox.size + @outbox.size
  end

  def enqueue(val)
    @inbox.push(val)
  end

  def shift_stacks
    if @outbox.is_empty?
      while(@inbox.is_empty? == false)
        @outbox.push(@inbox.pop)
      end
    end
  end

  def peek
    shift_stacks()
    @outbox.peek
  end

  def dequeue
    shift_stacks()
    @outbox.pop
  end

end


# 3.7 animal shelter problem

class Animal
  def initialize(name)
    @name = name
    @order = nil
  end

  def set_order(order)
    @order = order
  end

  def get_order
    @order
  end

  def is_older_than(other_animal)
    @order < other_animal.get_order
  end

end

class Dog < Animal
  @@type = "dog"
  attr_reader :type
  def get_type
    @@type
  end
end

class Cat < Animal
  @@type = "cat"
  def get_type
    @@type
  end
end

class Shelter
  def initialize
    @cats = LinkedList.new
    @dogs = LinkedList.new
    @order = 0
  end

  def enqueue(animal)
    animal.set_order(@order)
    @order += 1
    if animal.get_type == "dog"
      @dogs.add_to_tail(animal)
    else
      @cats.add_to_tail(animal)
    end
  end

  def dequeue_any
    if @dogs.size == 0
      dequeue_cat
    elsif @cats.size == 0
      dequeue_dog
    else
      dog = @dogs.peek
      cat = @cats.peek
      if (dog.is_older_than(cat))
        dequeue_dog
      else
        dequeue_cat
      end
    end
  end

  def dequeue_cat
    @cats.remove_from_head
  end

  def dequeue_dog
    @dogs.remove_from_head
  end

end

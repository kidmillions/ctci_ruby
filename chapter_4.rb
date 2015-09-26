class Tree
  def initialize(data, parent = nil)
    @data = data
    @parent = parent
    @children = []
  end


  def get_children
    @children
  end

  def get_data
    @data
  end

  def add_child(data)
    @children.push(Tree.new(data, self))
  end

  def contains(target)
    found = false
    traverse = lambda do |node|
      if (node.get_data == target)
        found = true
        return
      end
      node.get_children().each do |e|
        traverse.call(e)
      end
    end

    traverse.call(self)
    found

  end

end


class BinarySearchTree
  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end

  def get_data
    @data
  end

  def insert(val)
    if val < @data
      if @left == nil
        @left = BinarySearchTree.new(val)
      else
        @left.insert(val)
      end
    elsif val > @data
      if @right == nil
        @right = BinarySearchTree.new(val)
      else
        @right.insert(val)
      end
    else
      puts "The tree already contains this value!"
    end
  end


  def depth_first_log
    yield(@data)
    if @left != nil
      @left.depth_first_log do |e|
        yield(e)
      end
    end
    if @right != nil
      @right.depth_first_log do |e|
        yield(e)
      end
    end
  end

end

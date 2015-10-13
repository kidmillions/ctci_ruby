# 4.1 find if binary search tree is balanced


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

  def get_left
    @left
  end

  def get_right
    @right
  end

  def get_data
    @data
  end


  def self.check_height(tree)
    if tree === nil
      return 0
    else
      leftHeight = BinarySearchTree.check_height(tree.get_left)
      if leftHeight == -1
        return -1
      end

      rightHeight = BinarySearchTree.check_height(tree.get_right)
      if rightHeight == -1
        return -1
      end

      diff = (leftHeight - rightHeight).abs
      if diff > 1
        return -1
      else
        return [leftHeight, rightHeight].max + 1
      end
    end
  end


  def is_balanced?
    BinarySearchTree.check_height(self) != -1
  end

end

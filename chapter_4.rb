# 4.1 find if binary search tree is balanced
# 4.2 find if there is a route between two nodes

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


class Vertex
  def initialize(data)
    @data = data
    @edges = Hash.new
  end

  def get_data
    @data
  end

  def add_edge(other)
    @edges[other.get_data] = Edge.new(other)
  end

  attr_accessor :edges
end

class Edge
  def initialize(data)
    @next = data
  end

  attr_reader :next

end


class Graph
  def initialize()
    @vertexes = Hash.new
  end

  def add_vertex(vert)
    @vertexes[vert.get_data] = vert
  end

  def add_edges(from_vert, to_vert)
    if !@vertexes[from_vert.get_data] || !@vertexes[to_vert.get_data]
      raise 'Vertices are not in graph.'
    end
    from_vert.add_edge(to_vert)
  end

  def is_reachable(from_vert, to_vert)
      found = false
      visited = Hash.new(false)
      visit_nodes = lambda do |cur_node|

        if visited[cur_node.get_data]
          return
        end
        visited[cur_node.get_data] = true

        if cur_node == to_vert
          found = true
          return
        end

        cur_node.edges.each do |key, value|
          visit_nodes.call(value.next)
        end
      end

      visit_nodes.call(from_vert)
      found
  end

end

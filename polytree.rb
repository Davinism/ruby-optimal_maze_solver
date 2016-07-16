class PolyTreeNode
  attr_reader :parent, :children, :value

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(new_parent)
    parent.children.delete(self) unless parent.nil?
    @parent = new_parent
    unless new_parent.nil? || new_parent.children.include?(self)
      new_parent.children << self
    end
  end

  def add_child(child_node)
    unless children.include?(child_node)
      children << child_node
      child_node.parent = self
    end
  end

  def remove_child(child)
    raise "Node is not a child" unless children.include?(child)
    children.delete(child)
    child.parent = nil
  end

  def dfs(target_value)
    return self if value == target_value
    children.each do |child|
      result = child.dfs(target_value)
      return result unless result.nil?
    end
    nil
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.value == target_value
      queue += current_node.children
    end
    nil
  end
  
end

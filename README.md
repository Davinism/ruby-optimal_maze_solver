# Optimal Maze Solver

## Objective

In this project, we aimed to create a terminal maze solver that will find the shortest path to the end of the maze.

## Implementation Details

In order to find the shortest path to solve the maze, we used Breadth First Search to come up with all possible solutions to solving the maze and then selecting the shortest path.

```ruby
  def bfs(target_value)
    queue = [self]
    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.value == target_value
      queue += current_node.children
    end
    nil
  end
  
    def build_tree
    root = PolyTreeNode.new(maze.start)
    queue = [root]
    until queue.empty?
      current_node = queue.shift
      next_positions = new_positions(current_node.value)
      visited_positions.concat(next_positions)
      next_positions.each do |pos|
        node = PolyTreeNode.new(pos)
        node.parent = current_node
        current_node.add_child(node)
        queue << node
      end
    end

    root
  end

  def build_path(endpoint = maze.end)
    search_result = build_tree.bfs(endpoint)
    trace_path(search_result)
  end
```

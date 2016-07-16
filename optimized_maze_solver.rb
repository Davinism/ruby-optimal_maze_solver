require_relative 'maze.rb'
require_relative 'polytree.rb'

class OptimalMazeSolver
  def self.maze_from_file(maze_file)
    new_maze = Maze.new(maze_file)
    self.new(new_maze)
  end

  def initialize(maze)
    @maze = maze
    @visited_positions = [maze.start]
  end

  def new_positions(pos)
    row, col = pos
    results_arr = [[row + 1, col], [row - 1, col], [row, col + 1], [row, col - 1]]
    results_arr.reject do |coor|
      visited_positions.include?(coor) || maze[coor] == "*"
    end
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

  def trace_path(node)
    return [node.value] if node.parent.nil?
    trace_path(node.parent) + [node.value]
  end

  def animate_path
    path = build_path
    path.each do |pos|
      maze[pos] = "X"
      sleep(0.2)
      system("clear")
      maze.render
    end
  end

  private
  attr_reader :visited_positions, :maze
end

if __FILE__ == $PROGRAM_NAME
  solver = OptimalMazeSolver.maze_from_file("maze2.txt")
  solver.animate_path
end

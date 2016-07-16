require_relative 'maze.rb'

class MazeSolver

  attr_reader :maze

  DIRECTIONS = {
    :north => {:cw => :east, :ccw => :west},
    :east  => {:cw => :south, :ccw => :north},
    :west  => {:cw => :north, :ccw => :south},
    :south => {:cw => :west, :ccw => :east}
  }

  def initialize(maze_file)
    reset(maze_file)
  end

  def solve(maze_file)
    until won?
      if lost?
        reset(maze_file)
        solve(maze_file)
      elsif move_forward?
        move
        sleep(0.2)
        system "clear"
        @maze.render
      else
        turn_direction = [:cw, :ccw].sample
        turn(turn_direction)
      end
    end
    #@maze.render
  end

  def move
    case @direction
    when :north then @pos[0] -= 1
    when :east  then @pos[1] += 1
    when :south then @pos[0] += 1
    when :west  then @pos[1] -= 1
    end
    @maze[*@pos] = "X"
  end

  def detect
    x_cor, y_cor = @pos
    case @direction
    when :north then @maze[x_cor - 1, y_cor]
    when :east  then @maze[x_cor, y_cor + 1]
    when :south then @maze[x_cor + 1, y_cor]
    when :west  then @maze[x_cor, y_cor - 1]
    end
  end

  def move_forward?
    detect == " " || detect == "E"
  end

  def turn(rotation)
    @direction = DIRECTIONS[@direction][rotation]
  end

  def lost?
    x_cor, y_cor = @pos
    loss_conditions = ["X", "*"]
    loss_conditions.include?(@maze[x_cor - 1, y_cor]) &&
      loss_conditions.include?(@maze[x_cor, y_cor + 1]) &&
      loss_conditions.include?(@maze[x_cor + 1, y_cor]) &&
      loss_conditions.include?(@maze[x_cor, y_cor - 1])
  end

  def won?
    @pos == @maze.end
  end

  def reset(maze_file)
    @maze = Maze.new(maze_file)
    @direction = :north
    @pos = @maze.start
  end
end

if __FILE__ == $PROGRAM_NAME
  my_solver = MazeSolver.new("maze.txt")
  my_solver.solve("maze.txt")
end

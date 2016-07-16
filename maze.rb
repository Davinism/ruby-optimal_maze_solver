require 'byebug'

class Maze

  attr_reader :start, :end, :grid

  def initialize(file_name)
    @grid = File.readlines(file_name).map(&:chomp).map { |line| line.split("") }
    @start = find_point("S")
    @end = find_point("E")
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    @grid[x][y] = value
  end

  def render
    @grid.each do |row|
      puts row.join("")
    end
    nil
  end

  def find_point(str)
    @grid.each_with_index do |row, idx|
      row.each_index do |jdx|
        return [idx, jdx] if self[[idx, jdx]] == str
      end
    end
    nil
  end

end

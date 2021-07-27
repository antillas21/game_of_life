require_relative './cell.rb'

class World
  def initialize(width:, height:)
    @width = width
    @height = height
    @cells = build_cells
  end

  def start
    random_living_cells_count.times
                             .map { |_| find_at(rand(@width - 1), rand(@height - 1)) }
                             .compact
                             .map(&:toggle!)
  end

  def cells
    @cells.flatten
  end

  def find_at(x, y)
    cells.detect { |cell| cell.x == x && cell.y == y }
  end

  def living_cells
    cells.select(&:alive?)
  end

  def dead_cells
    cells.select(&:dead?)
  end

  private

  def build_cells
    cells = []
    @height.times.each { |y_idx| cells.push(build_row(y_idx)) }

    cells
  end

  def build_row(y_idx)
    row = []
    @width.times.each { |x_idx| row.push(::Cell.new(world: self, x: x_idx, y: y_idx)) }

    row
  end

  def random_living_cells_count
    (@width / 2).times.map { |i| rand(@height) }.sum
  end
end

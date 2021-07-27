require_relative './cell.rb'

class World
  def initialize(config:)
    @config = config
    @cells = build_cells
  end

  def start
    @config.initial_living_count.times
                                .map { |_| find_at(rand(@config.width - 1), rand(@config.height - 1)) }
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
    @config.height
           .times
           .each { |y_idx| cells.push(build_row(y_idx)) }

    cells
  end

  def build_row(y_idx)
    row = []
    @config.width
           .times
           .each { |x_idx| row.push(::Cell.new(world: self, x: x_idx, y: y_idx)) }

    row
  end
end

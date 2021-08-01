require 'dry-configurable'

require_relative './cell'
require_relative './rules'

class World
  include Dry::Configurable

  setting :width, 10
  setting :height, 10

  def initialize
    @cells = build_cells
    @rules_klasses = ::Rules::Base.registry
  end

  def setup(cells: cells_list)
    cells.each do |coords|
      cell = find_at(coords[:x], coords[:y])
      return unless cell

      cell.toggle!
    end
  end

  def play(iterations:)
    iterations.times do
      @rules_klasses.map { |rule_klass| rule_klass.new(world: self) }
                    .map(&:apply)
                    .flatten
                    .map(&:toggle!)
    end
  end


  def cells
    @cells.flatten
  end

  def find_at(x, y)
    cells.detect { |cell| cell.x == x && cell.y == y }
  end

  def living_cells
    filter(:alive?)
  end

  def dead_cells
    filter(:dead?)
  end

  def filter(status)
    cells.select(&status)
  end

  def inspect
    "#<World:#{"0x00%x" % (object_id << 1)}>"
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

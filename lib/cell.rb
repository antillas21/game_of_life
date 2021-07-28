class Cell
  attr_reader :x, :y

  def initialize(world:, x:, y:)
    @world = world
    @x = x
    @y = y
    @living = false
  end

  def alive?
    @living
  end

  def dead?
    !alive?
  end

  def toggle!
    @living = !@living
  end

  def coordinates
    {
      x: @x,
      y: @y
    }
  end

  def alive_neighbors
    neighbors.select(&:alive?)
  end

  def neighbors
    neighboring_coordinates.map { |x, y| @world.find_at(x, y) }
                           .compact
  end

  def inspect
    "#<Cell:#{"0x00%x" % (object_id << 1)} @x=#{@x}, @y=#{@y}, @living=#{@living}>"
  end

  private

  def neighboring_coordinates
    [
      [(x - 1), y],
      [(x + 1), y],
      [x, (y - 1)],
      [x, (y + 1)],
      [(x - 1), (y - 1)],
      [(x + 1), (y - 1)],
      [(x - 1), (y + 1)],
      [(x + 1), (y + 1)]
    ]
  end
end

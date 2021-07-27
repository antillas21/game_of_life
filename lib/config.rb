class Config

  attr_reader :width, :height, :initial_living_count

  def initialize(attributes = {})
    @width = attributes.fetch(:width)
    @height = attributes.fetch(:height)
    @initial_living_count = attributes.fetch(:living_count,
                                             initial_living_cells_count)
  end

  private

  # it sets a random count of cells that will be set to #live
  # in the first iteration
  def initial_living_cells_count
    (@width / 2).times
                .map { |i| rand(@height) }
                .sum
  end
end

module Rules
  class Overpopulation < Base
    private

    def cell_status
      :alive?
    end

    def should_toggle?(cell)
      cell.alive_neighbors
          .size > 3
    end
  end
end

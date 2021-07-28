module Rules
  class Underpopulation < Base
    private

    def cell_status
      :alive?
    end

    def should_toggle?(cell)
      cell.alive_neighbors
          .size < 2
    end
  end
end

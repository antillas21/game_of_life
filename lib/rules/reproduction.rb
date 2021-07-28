module Rules
  class Reproduction < Base
    private

    def cell_status
      :dead?
    end

    def should_toggle?(cell)
      cell.alive_neighbors
          .size == 3
    end
  end
end

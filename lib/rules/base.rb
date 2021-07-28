module Rules
  class Base
    def self.registry
      @registry ||= []
    end

    def self.register(candidate)
      registry.append(candidate)
    end

    def self.inherited(candidate)
      register(candidate)
    end

    def initialize(world:)
      @world = world
    end

    def apply
      cells.select { |cell| should_toggle?(cell) }
    end

    private

    def cell_status
      raise("Must be either `:alive?` or `:dead?`")
    end

    def cells
      @world.filter(cell_status)
    end

    def should_toggle?(_cell)
      raise("Must be implemented.")
    end
  end
end

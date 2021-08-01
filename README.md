# Game of Life

This is a sample implementation of Conway's Game of Life in Ruby.
Usage is simple, clone this repo and open a Ruby console (via IRB or Pry)

```ruby
# load project main entry
load 'game_of_life.rb'

# instantiate and configure a world
world = World.new
world.config.width = 6
world.config.height = 6

# setup cell coordinates to start as living cells
cells = [
  { x: 1, y: 2 },
  { x: 2, y: 2 },
  { x: 1, y: 3 },
  { x: 3, y: 2 },
  { x: 1, y: 4 },
  { x: 4, y: 2 },
  { x: 4, y: 1 },
  { x: 0, y: 2 },
  { x: 1, y: 0 },
  { x: 2, y: 1 },
  { x: 0, y: 4 },
  { x: 4, y: 0 },
  { x: 3, y: 0 },
  { x: 2, y: 4 },
  { x: 3, y: 3 }
]

world.setup(cells: cells)

# inspect cells are really living
world.living_cells.map(&:coordinates)

# play and inspect the world after as many iterations as you want
world.play(iterations: 5)
world.living_cells.map(&:coordinates)
# they should not be the ones orginally set as living
```

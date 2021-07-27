require 'world'

RSpec.describe World do
  let(:world) { described_class.new(width: width, height: height) }
  let(:width) { 10 }
  let(:height) { 10 }

  it 'has width x height cells' do
    expect(world.cells.size).to eq(width * height)
  end

  describe '#find_at' do
    subject { world.find_at(x, y) }
    let(:x) { 3 }
    let(:y) { 4 }

    it 'retrieves cell with x: x, y: y' do
      expect(subject.coordinates).to eq({ x: x, y: y })
    end
  end

  describe '#living_cells' do
    subject { world.living_cells }

    let(:living_cell) { world.find_at(3, 4) }

    before do
      living_cell.toggle!
    end

    it 'retrieves cells that are alive' do
      expect(subject).to include(living_cell)
    end
  end

  describe '#dead_cells' do
    subject { world.dead_cells }

    let(:dead_cell) { world.find_at(3, 4) }

    it 'retrieves cells that are dead' do
      expect(subject).to include(dead_cell)
    end
  end

  describe '#start' do
    subject { world.start }

    it 'sets a random set of cells to alive' do
      subject
      expect(world.living_cells).to_not be_empty
    end
  end
end

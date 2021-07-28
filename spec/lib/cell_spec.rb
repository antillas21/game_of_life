require 'cell'
require 'world'

RSpec.describe Cell do
  let(:config) do
    instance_double('Config',
                    width: width,
                    height: height,
                    initial_living_count: initial_count)
  end
  let(:world) { instance_double('World') }
  let(:cell) { Cell.new(world: world, x: x, y: y) }
  let(:x) { 3 }
  let(:y) { 4 }
  let(:width) { 5 }
  let(:height) { 5 }
  let(:initial_count) { 7 }

  describe '#coordinates' do
    subject { cell.coordinates }

    it 'is a Hash' do
      expect(subject).to be_a(Hash)
    end

    it 'includes x, y values' do
      expect(subject).to eq({ x: x, y: y })
    end
  end

  describe '#alive?' do
    it 'defaults to false' do
      expect(cell).to_not be_alive
    end

    it 'can be true' do
      cell.toggle!
      expect(cell).to be_alive
    end
  end

  describe '#dead?' do
    it 'defaults to true' do
      expect(cell).to be_dead
    end

    it 'can be false' do
      cell.toggle!
      expect(cell).to_not be_dead
    end
  end

  describe '#toggle!' do
    subject { cell.toggle! }

    context 'when alive' do
      before do
        cell.toggle!
      end

      it 'changes to dead' do
        subject
        expect(cell).to be_dead
      end
    end

    context 'when dead' do
      it 'changes to alive' do
        subject
        expect(cell).to be_alive
      end
    end
  end

  describe '#neighbors' do
    let(:world) { World.new(config: config) }
    let(:cell) { world.find_at(3, 3) }

    subject { cell.neighbors.map(&:coordinates) }

    it 'retrieves correct neighbors' do
      expect(subject).to match_array([
        { x: 2, y: 3},
        { x: 4, y: 3},
        { x: 3, y: 2},
        { x: 3, y: 4},
        { x: 2, y: 2},
        { x: 4, y: 2},
        { x: 2, y: 4},
        { x: 4, y: 4}
      ])
    end
  end
end

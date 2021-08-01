require 'world'

RSpec.describe World do
  let(:world) { described_class.new }

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

  describe '#setup' do
    subject { world.setup(cells: cells_list) }

    let(:cells_list) { [cell_a, cell_b] }
    let(:cell_a) { { x: 1, y: 1 } }
    let(:cell_b) { { x: 2, y: 2 } }

    it 'sets a group of cells to alive' do
      subject
      expect(world.living_cells).to_not be_empty
    end

    it 'sets the cells in argument to alive' do
      subject
      expect(world.living_cells.map(&:coordinates)).to match_array([cell_a, cell_b])
    end

    context 'with invalid coordinate' do
      let(:cell_b) { { x: -1, y: -1 } }

      it 'ignores cell coordinate' do
        expect { subject }.to_not raise_error
      end
    end
  end

  describe '#play' do
    subject { world.play(iterations: iterations) }

    let(:iterations) { 2 }
    let!(:rules_klasses) { Rules::Base.registry }

    it 'requires iterations argument' do
      expect { world.play }.to raise_error(ArgumentError)
    end
  end
end

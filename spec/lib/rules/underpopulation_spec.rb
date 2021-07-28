require 'rules/base'
require 'rules/underpopulation'

RSpec.describe Rules::Underpopulation do
  let(:rule) { described_class.new(world: world) }
  let(:world) { instance_double('World', filter: cells) }
  let(:cells) { [cell] }
  let(:cell) { instance_double('Cell', alive_neighbors: alive_neighbors) }

  describe '#apply' do
    subject { rule.apply }

    context 'when alive neighbors less than 2' do
      let(:alive_neighbors) { [instance_double('Cell')] }

      it 'returns cell as part of affected instances' do
        expect(subject).to match_array([cell])
      end
    end

    shared_examples_for 'not an affected instance' do
      it 'does not include cell' do
        expect(subject).to_not include(cell)
      end
    end

    context 'when alive neighbors equal to 2' do
      let(:alive_neighbors) do
        [
          instance_double('Cell'),
          instance_double('Cell')
        ]
      end

      it_behaves_like 'not an affected instance'
    end

    context 'when alive neighbors greater than 2' do
      let(:alive_neighbors) do
        [
          instance_double('Cell'),
          instance_double('Cell'),
          instance_double('Cell')
        ]
      end

      it_behaves_like 'not an affected instance'
    end
  end
end

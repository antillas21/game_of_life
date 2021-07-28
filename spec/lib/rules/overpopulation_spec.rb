require 'rules/base'
require 'rules/overpopulation'

RSpec.describe Rules::Overpopulation do
  let(:rule) { described_class.new(world: world) }
  let(:world) { instance_double('World', filter: cells) }
  let(:cells) { [cell] }
  let(:cell) { instance_double('Cell', alive_neighbors: alive_neighbors) }

  describe '#apply' do
    subject { rule.apply }

    shared_examples_for 'not an affected instance' do
      it 'does not include cell' do
        expect(subject).to_not include(cell)
      end
    end

    context 'when alive neighbors are less than 3' do
      let(:alive_neighbors) do
        [
          instance_double('Cell'),
          instance_double('Cell')
        ]
      end

      it_behaves_like 'not an affected instance'
    end

    context 'when alive neighbors are equal to 3' do
      let(:alive_neighbors) do
        [
          instance_double('Cell'),
          instance_double('Cell'),
          instance_double('Cell')
        ]
      end

      it_behaves_like 'not an affected instance'
    end

    context 'when alive neighbors are greater than 3' do
      let(:alive_neighbors) do
        [
          instance_double('Cell'),
          instance_double('Cell'),
          instance_double('Cell'),
          instance_double('Cell')
        ]
      end

      it 'returns cell as part of affected instances' do
        expect(subject).to match_array([cell])
      end
    end
  end
end

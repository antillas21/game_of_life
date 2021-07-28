require 'rules/base'

RSpec.describe Rules::Base do
  it 'requires a world instance' do
    expect { described_class.new }.to raise_error(ArgumentError)
  end

  describe '#apply' do
    subject { rule.apply }

    let(:rule) { described_class.new(world: world) }
    let(:world) { double('World', filter: cells) }
    let(:cells) { [double('Cell')] }

    before do
      allow(rule).to receive(:cell_status).and_return(:alive?)
    end

    it 'acts on selected cells' do
      expect(cells).to receive(:select)
      subject
    end
  end

  describe 'class features' do
    class Rules::Foo < Rules::Base
    end

    it 'keeps a registry of descendants' do
      expect(Rules::Base.registry).to include(Rules::Foo)
    end
  end
end

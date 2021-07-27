require 'config'

RSpec.describe Config do
  let(:config) { described_class.new(attributes) }
  let(:attributes) do
    {
      width: 10,
      height: 25,
      living_count: 50
    }
  end

  it 'does not raise error' do
    expect { config }.to_not raise_error
  end

  describe 'living_count param' do
    before do
      attributes.delete(:living_count)
    end

    it 'is optional' do
      expect { config }.to_not raise_error
    end

    it 'is set to a random value when missing' do
      expect(config.initial_living_count).to_not be_nil
    end
  end
end

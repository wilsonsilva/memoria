RSpec.describe Memoria::Snapshot do
  describe '.initialize' do
    it 'sets the name attribute' do
      snapshot = described_class.new('original name')
      expect(snapshot.instance_variable_get(:@name)).to eq('original name')
    end
  end

  describe '#name' do
    it 'exposes the name of the snapshot' do
      snapshot = described_class.new('original name')
      expect(snapshot.name).to eq('original name')
    end
  end
end

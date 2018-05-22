RSpec.describe Memoria::Errors::InvalidSnapshotExtension do
  describe '#message' do
    it 'returns exception’s description' do
      error = described_class.new
      expect(error.message).to eq('The snapshot extension is invalid.')
    end
  end
end

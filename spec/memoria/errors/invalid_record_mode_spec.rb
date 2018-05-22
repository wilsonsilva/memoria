RSpec.describe Memoria::Errors::InvalidRecordMode do
  describe '#message' do
    it 'returns exception’s description' do
      error = described_class.new
      expect(error.message).to eq(
        'The snapshot record mode is invalid. The only valid modes are :all, :none and :new_snapshots.'
      )
    end
  end
end

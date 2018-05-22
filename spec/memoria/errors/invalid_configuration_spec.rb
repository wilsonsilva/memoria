RSpec.describe Memoria::Errors::InvalidConfiguration do
  describe '#message' do
    it 'returns exception’s description' do
      error = described_class.new
      expect(error.message).to eq("Memoria's configuration is invalid.")
    end
  end
end

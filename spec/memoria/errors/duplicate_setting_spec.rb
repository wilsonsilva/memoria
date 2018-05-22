RSpec.describe Memoria::Errors::DuplicateSetting do
  describe '#message' do
    it 'returns exception’s description' do
      error = described_class.new
      expect(error.message).to eq("There's already a setting with that name.")
    end
  end
end

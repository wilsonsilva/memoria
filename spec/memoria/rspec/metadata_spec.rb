RSpec.describe Memoria::RSpec::Metadata do
  describe '#current_example_metadata' do
    it 'returns the metadata of the current example' do
      expect(current_example_metadata).to include(
        description: '#current_example_metadata',
        full_description: 'Memoria::RSpec::Metadata#current_example_metadata',
        described_class: described_class
      )
    end
  end
end

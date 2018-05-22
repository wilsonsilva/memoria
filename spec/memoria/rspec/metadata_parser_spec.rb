# These tests do not adhere to betterspecs.org due to their own reflexive nature.

RSpec.describe Memoria::RSpec::MetadataParser do
  describe '#find_description_for' do
    it 'returns the description of the current example and the parent example group' do
      description = described_class.find_description_for(current_example_metadata)
      expect(description).to eq('Memoria::RSpec::MetadataParser/#find_description_for')
    end

    context 'when inside an example group' do
      it 'returns the description of the current example group and parent example groups' do
        description = described_class.find_description_for(current_example_metadata)
        expect(description).to eq('Memoria::RSpec::MetadataParser/#find_description_for/when inside an example group')
      end
    end
  end

  it 'find_description_for returns the description of the example when there is no example group' do
    description = described_class.find_description_for(current_example_metadata)
    expect(description).to eq('Memoria::RSpec::MetadataParser')
  end
end

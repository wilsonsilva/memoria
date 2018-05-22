RSpec.describe Memoria::Configuration do
  let(:configuration) { described_class.new }

  describe '#initialize' do
    it 'sets the default record mode to new episodes' do
      instance = described_class.new
      expect(instance.snapshot_record_mode).to eq(:new_episodes)
    end

    it 'sets the default record extension to snap' do
      instance = described_class.new
      expect(instance.snapshot_extension).to eq('snap')
    end
  end

  describe '#snapshot_record_mode' do
    before { configuration.snapshot_record_mode = :all }

    it 'exposes the snapshot record mode' do
      expect(configuration.snapshot_record_mode).to eq(:all)
    end
  end

  describe '#snapshot_record_mode=' do
    context 'when the snapshot record mode is invalid' do
      it 'raises an exception' do
        expect { configuration.snapshot_record_mode = :fake_news }.to raise_error(Memoria::Errors::InvalidRecordMode)
      end
    end

    context 'when the snapshot record mode is valid' do
      it 'sets the snapshot record mode' do
        configuration.snapshot_record_mode = :all
        expect(configuration.snapshot_record_mode).to eq(:all)
      end
    end
  end

  describe '#snapshot_extension' do
    before { configuration.snapshot_extension = 'snap' }

    it 'exposes the snapshot extension' do
      expect(configuration.snapshot_extension).to eq('snap')
    end
  end

  describe '#snapshot_extension=' do
    context 'when the snapshot extension is invalid' do
      it 'raises an exception' do
        expect { configuration.snapshot_extension = '.ha!' }.to raise_error(Memoria::Errors::InvalidSnapshotExtension)
      end
    end

    context 'when the snapshot extension is valid' do
      it 'sets the snapshot record mode' do
        configuration.snapshot_extension = 'snapshot'
        expect(configuration.snapshot_extension).to eq('snapshot')
      end
    end
  end

  describe '#snapshot_directory' do
    before { configuration.snapshot_directory = 'spec/fixtures/snapshots' }

    it 'exposes the snapshot record directory' do
      expect(configuration.snapshot_directory).to eq('spec/fixtures/snapshots')
    end
  end

  describe '#snapshot_directory=' do
    it 'sets the directory where all snapshots will be stored' do
      configuration.snapshot_directory = 'spec/fixtures/snapshots'
      expect(configuration.snapshot_directory).to eq('spec/fixtures/snapshots')
    end
  end

  describe '#add_setting' do
    context 'when the setting already exists' do
      before do
        configuration.add_setting(:existing_setting) {}
      end

      it 'raises an exception' do
        expect do
          configuration.add_setting(:existing_setting) {}
        end.to raise_error(Memoria::Errors::DuplicateSetting)
      end
    end

    context 'when the setting does not exist' do
      it 'defines a new setting' do
        configuration.add_setting(:configure_it) { 'the return value' }
        expect(configuration.configure_it).to eq('the return value')
      end
    end

    context 'when called without a block' do
      it 'returns an error' do
        expect { configuration.add_setting(:no_block) }.to raise_error(TypeError)
      end
    end
  end
end

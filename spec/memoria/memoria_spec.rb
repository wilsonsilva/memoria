RSpec.describe Memoria do
  after { described_class.snapshots.clear }

  it 'has a version number' do
    expect(described_class::VERSION).not_to be nil
  end

  describe '#current_snapshot' do
    it 'exposes the last recorded snapshot' do
      described_class.record('old-snapshot')
      described_class.record('new-snapshot')
      snapshot = described_class.current_snapshot

      expect(snapshot.name).to eq('new-snapshot')
    end
  end

  describe '#configure' do
    let(:configuration) { described_class::Configuration.new }

    before { allow(described_class).to receive(:configuration).and_return(configuration) }

    it 'configures the snapshot recording' do
      described_class.configure do |configuration|
        configuration.snapshot_extension = 'snappy'
      end

      expect(described_class.configuration.snapshot_extension).to eq('snappy')
    end
  end

  describe '#configuration' do
    it 'exposes the gem configuration' do
      expect(described_class.configuration).to be_an_instance_of(described_class::Configuration)
    end
  end

  describe '#snapshots' do
    it 'exposes an array of snapshots' do
      expect(described_class.snapshots).to eq([])
    end
  end

  describe '#snapshot_saver' do
    it 'exposes the snapshot persistence entity' do
      expect(described_class.snapshot_saver).to be_an_instance_of(described_class::SnapshotSaver)
    end
  end

  describe '#record' do
    it 'creates a new snapshot' do
      described_class.record('snapshot-name')
      snapshot = described_class.snapshots.first

      expect(snapshot.name).to eq('snapshot-name')
    end
  end

  describe '#stop_recording' do
    it 'removes the last snapshot' do
      described_class.record('snapshot-name')
      described_class.stop_recording

      expect(described_class.snapshots).to be_empty
    end
  end
end

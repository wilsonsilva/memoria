RSpec.describe Memoria::SnapshotSaver do
  let(:snapshot_directory) { TestHelpers::FileSystem.create_directory }
  let(:configuration) do
    conf = Memoria::Configuration.new
    conf.snapshot_directory = snapshot_directory
    conf
  end

  let(:snapshot_saver) { described_class.new(configuration) }

  after do
    TestHelpers::FileSystem.teardown
  end

  describe '#snapshot_exists?' do
    context 'when the file exists' do
      let(:snapshot_name) { 'snapshot' }

      before { TestHelpers::FileSystem.create_file(snapshot_directory, snapshot_name) }

      it 'returns true' do
        expect(snapshot_saver.snapshot_exists?(snapshot_name)).to eq(true)
      end
    end

    context 'when the file does not exist' do
      it 'returns false' do
        expect(snapshot_saver.snapshot_exists?('404')).to eq(false)
      end
    end
  end

  describe '#read' do
    context 'when the file exists' do
      let(:snapshot_name) { 'read_snapshot' }

      before { TestHelpers::FileSystem.create_file(snapshot_directory, snapshot_name) }

      it 'returns the file contents' do
        expect(snapshot_saver.read(snapshot_name)).to eq('initial')
      end
    end

    context 'when the file does not exist' do
      it 'returns nil' do
        expect(snapshot_saver.read('404')).to eq(nil)
      end
    end
  end

  describe '#write' do
    context 'when the file exists' do
      let(:snapshot_name) { 'write_snapshot' }

      before { TestHelpers::FileSystem.create_file(snapshot_directory, snapshot_name) }

      it 'overwrites the file contents' do
        snapshot_saver.write(snapshot_name, 'overwritten')
        expect(snapshot_saver.read(snapshot_name)).to eq('overwritten')
      end
    end

    context 'when the file does not exist' do
      let(:snapshot_name) { 'new_snapshot' }

      it 'creates a new file with the contents' do
        snapshot_saver.write(snapshot_name, 'new contents')
        expect(snapshot_saver.read(snapshot_name)).to eq('new contents')
      end
    end
  end
end

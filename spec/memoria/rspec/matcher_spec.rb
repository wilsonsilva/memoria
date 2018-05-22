RSpec.describe 'Memoria::RSpec::Matcher' do
  describe '#match_snapshot' do
    context 'when the expected output matches a saved snapshot', snapshot: true do
      it 'matches the snapshot' do
        output = '<strong>Thanos</strong>'
        expect(output).to match_snapshot
      end
    end

    context 'when the expected output does not match a saved snapshot', snapshot: true do
      it 'does not match the snapshot' do
        output = 'Thanos'
        expect(output).not_to match_snapshot
      end
    end

    context 'when the snapshot does not exist', snapshot: true do
      let(:snapshot_saver) { instance_double('Memoria::SnapshotSaver', snapshot_exists?: false, write: nil) }

      let(:snapshot_name) do
        'Memoria::RSpec::Matcher/#match_snapshot/when the snapshot does not exist/stores a snapshot and passes the test'
      end

      before { allow(Memoria).to receive(:snapshot_saver).and_return(snapshot_saver) }

      it 'stores a snapshot and passes the test' do
        output = 'Thanos'

        aggregate_failures do
          expect(output).to match_snapshot
          expect(Memoria.snapshot_saver).to have_received(:write).with(snapshot_name, 'Thanos')
        end
      end
    end

    context 'when the metadata disables the snapshot recording', snapshot: false do
      it 'does not record any snapshot' do
        aggregate_failures do
          expect(Memoria.snapshots).to be_empty
          expect(Memoria.current_snapshot).to be_nil
        end
      end
    end
  end
end

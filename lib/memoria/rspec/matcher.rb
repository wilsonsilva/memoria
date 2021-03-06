require 'rspec/expectations'

RSpec::Matchers.define :match_snapshot do
  diffable

  match do |actual|
    snapshot_name = Memoria.current_snapshot.name

    if snapshot_saver.snapshot_exists?(snapshot_name)
      @expected = snapshot_saver.read(snapshot_name)
      expect(expected).to eq(actual)
    else
      snapshot_saver.write(snapshot_name, actual)
      RSpec.configuration.reporter.message "Generated snapshot: #{snapshot_name}"
      true
    end
  end

  # :nocov:
  failure_message do
    'Received value does not match the stored snapshot'
  end
  # :nocov:

  def snapshot_saver
    Memoria.snapshot_saver
  end

  attr_reader :expected
end

require 'memoria/configuration'
require 'memoria/snapshot'
require 'memoria/snapshot_saver'
require 'memoria/version'

# Encapsulates and provides access to the public interface of the gem.
module Memoria
  extend self

  # The last recorded snapshot.
  #
  # @example
  #   Memoria.record('name-of-snapshot')
  #   Memoria.current_snapshot # => #<Memoria::Snapshot:0x00007fc5610a17b0 @name="name-of-snapshot">
  #
  # @return [Snapshot] The current snapshot or nil if there is no current snapshot.
  #
  # @api public
  #
  def current_snapshot
    snapshots.last
  end

  # Configures Memoria.
  #
  # @example
  #    Memoria.configure do |config|
  #      config.snapshot_extension = 'snappy'
  #      config.snapshot_record_mode = :new_episodes
  #      config.add_setting :custom_setting_name do
  #        Time.now
  #      end
  #    end
  #
  # @yield The configuration block.
  # @yieldparam config [Configuration] The configuration object.
  # @return [void]
  #
  # @see Memoria::Configuration The configuration object and its available configuration options.
  #
  # @api public
  #
  def configure
    yield configuration
  end

  # Exposes the gem's configuration.
  #
  # @example
  #   Memoria.configuration.snapshot_extension # => 'snap'
  #
  # @return [Configuration] The Memoria configuration.
  #
  # @api public
  #
  def configuration
    @configuration ||= Configuration.new
  end

  # Returns the list of recorded snapshots.
  #
  # @example
  #   Memoria.record('name-of-snapshot-one')
  #   Memoria.snapshots # => [#<Memoria::Snapshot:0x00007fc7a3870808 @name="name-of-snapshot-one">]
  #
  # @return [Array<Snapshot>] An array of recorded snapshots.
  #
  # @api public
  #
  def snapshots
    @snapshots ||= []
  end

  # Returns an entity to persist snapshots (on the file system).
  #
  # @example
  #   snapshot_saver = Memoria.snapshot_saver
  #   snapshot_saver.save(Snapshot.new('index-page'))
  #
  # @return [SnapshotSaver] Reads and writes snapshots to the disk.
  #
  # @api public
  #
  def snapshot_saver
    @snapshot_saver ||= SnapshotSaver.new(configuration)
  end

  # Records a new snapshot.
  #
  # @example
  #   Memoria.record('name-of-snapshot')
  #   Memoria.current_snapshot # => #<Memoria::Snapshot:0x00007fc5610a17b0 @name="name-of-snapshot">
  #
  # @param [String] snapshot_name The name of the snapshot.
  # @return [Snapshot] A new snapshot.
  #
  # @api public
  #
  def record(snapshot_name)
    snapshot = Snapshot.new(snapshot_name)
    snapshots.push(snapshot)
  end

  # Stops recording snapshots.
  #
  # @example
  #   Memoria.record('name-of-snapshot')
  #   Memoria.current_snapshot # => #<Memoria::Snapshot:0x00007fc5610a17b0 @name="name-of-snapshot">
  #   Memoria.stop_recording
  #   Memoria.current_snapshot # => nil
  #
  # @return [Array] An empty array.
  #
  # @api public
  #
  def stop_recording
    snapshots.clear
  end
end

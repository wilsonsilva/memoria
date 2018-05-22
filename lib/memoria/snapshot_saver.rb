require 'fileutils'

module Memoria
  # Reads and writes snapshots to and from the file system.
  class SnapshotSaver
    # Creates a new SnapshotSaver.
    #
    # @example
    #   snapshot_saver = SnapshotSaver.new(Configuration.new)
    #
    # @param [Configuration] configuration The gem's configuration.
    #
    # @return [SnapshotSaver] An instance of +SnapshotSaver+.
    #
    # @api public
    #
    def initialize(configuration)
      @configuration = configuration
    end

    # Whether a snapshot for the given storage key (file name) is persisted in the file system.
    #
    # @example
    #   snapshot_saver = SnapshotSaver.new(Configuration.new)
    #   snapshot_saver.snapshot_exists?(Snapshot.new('does-not')) # => false
    #
    # @param [String] file_name The storage key (file name) of the snapshot.
    #
    # @return [SnapshotSaver] An instance of +SnapshotSaver+.
    #
    # @api public
    #
    def snapshot_exists?(file_name)
      location = absolute_path_to_file(file_name)
      return false if location.nil?
      File.exist?(location)
    end

    # Retrieves the snapshot contents for the given storage key (file name).
    #
    # @example When there is no snapshot for a given storage key (file name).
    #   snapshot_saver = SnapshotSaver.new(Configuration.new)
    #   snapshot_saver.read('/404') # => nil
    #
    # @example When there is a snapshot for a given storage key (file name).
    #   snapshot_saver = SnapshotSaver.new(Configuration.new)
    #   snapshot_saver.read('index_page') # => '<h1>Hello World</h1>'
    #
    # @param [String] file_name The storage key (file name) of the snapshot.
    #
    # @return [String] The snapshot content.
    #
    # @api public
    #
    def read(file_name)
      path = absolute_path_to_file(file_name)
      return nil unless File.exist?(path)
      File.read(path)
    end

    # Persists the snapshot contents for the given storage key (file name).
    #
    # @example
    #   snapshot_saver = SnapshotSaver.new(Configuration.new)
    #   snapshot_saver.write('index_page', 'Homepage')
    #   snapshot_saver.read('index_page') # => 'Homepage'
    #
    # @param [String] file_name The storage key (file name) of the snapshot.
    #
    # @param [String] content The snapshot content.
    #
    # @return [Fixnum] The length written.
    #
    # @api public
    #
    def write(file_name, content)
      path = absolute_path_to_file(file_name)
      directory = File.dirname(path)
      FileUtils.mkdir_p(directory) unless File.exist?(directory)
      File.binwrite(path, content)
    end

    private

    # Returns the gem's configuration.
    #
    # @return [Configuration] The gem's configuration.
    #
    attr_reader :configuration

    # Returns the absolute path to a given file, including the snapshot extension.
    #
    # @param [String] file_name The storage key (file name) of the snapshot.
    #
    # @return [String]
    #
    def absolute_path_to_file(file_name)
      return nil unless storage_location
      absolute_file_name = File.join(storage_location, sanitized_file_name_from(file_name) + file_extension)
      File.expand_path(absolute_file_name)
    end

    # Sanitizes a given storage key (file name) to be a valid file name.
    #
    # @param [String] file_name The storage key (file name) of the snapshot.
    #
    # @return [String] A sanitized file name.
    #
    def sanitized_file_name_from(file_name)
      parts = file_name.to_s.split('.')

      file_extension = '.' + parts.pop if parts.size > 1 && !parts.last.include?(File::SEPARATOR)

      parts.join('.').gsub(%r{[^[:word:]\-\/]+}, '_') + file_extension.to_s
    end

    # Returns the file extension for snapshots.
    #
    # @return [String] Extension for snapshots.
    #
    def file_extension
      '.' + configuration.snapshot_extension
    end

    # Returns the path to the directory where snapshots are saved.
    #
    # @return [String] Path to the directory where snapshots are saved.
    #
    def storage_location
      configuration.snapshot_directory
    end
  end
end

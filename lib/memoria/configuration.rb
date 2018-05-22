require 'memoria/errors'

module Memoria
  # Stores the configuration of the gem.
  class Configuration
    # The only allowed snapshot record modes.
    VALID_SNAPSHOT_RECORD_MODES = %i[all new_episodes none].freeze

    # @return [String] Directory where the snapshots will be saved
    # @api public
    #
    attr_accessor :snapshot_directory

    # @return [String] The way the snapshots are recorded.
    # @api public
    #
    attr_reader :snapshot_record_mode

    # @return [String] File extension of new snapshots.
    # @api public
    #
    attr_reader :snapshot_extension

    # Creates an instance of the configuration.
    #
    # @example
    #   configuration = Memoria::Configuration.new
    #
    # @return [Configuration] An instance of +Configuration+.
    #
    # @api public
    #
    def initialize
      self.snapshot_extension = 'snap'
      self.snapshot_record_mode = :new_episodes
    end

    # Sets the extension for new snapshots.
    #
    # @param [Symbol] snapshot_extension The new snapshot extension.
    # @raise [Errors::InvalidSnapshotExtension] If the snapshot extension is not valid.
    #
    # @return [String] The given snapshot extension.
    #
    # @api public
    #
    def snapshot_extension=(snapshot_extension)
      validate_snapshot_extension(snapshot_extension)
      @snapshot_extension = snapshot_extension
    end

    # Sets the snapshot record mode. TODO
    #
    # @param [Symbol] record_mode The new snapshot record mode.
    # @raise [Errors::InvalidRecordMode] If record mode is not one of +VALID_SNAPSHOT_RECORD_MODES+
    #
    # @return [String] The given snapshot extension.
    #
    # @api public
    #
    def snapshot_record_mode=(record_mode)
      validate_record_mode(record_mode)
      @snapshot_record_mode = record_mode
    end

    # Adds a new setting with the given +name+.
    #
    # @example Configuring a setting directly.
    #   configuration = Memoria::Configuration
    #   configuration.add_setting(:now) do
    #     Time.now
    #   end
    #
    # @example Configuring a setting through Memoria's DSL.
    #   Memoria.configure do |config|
    #     config.add_setting(:now) do
    #       Time.now
    #     end
    #   end
    #
    # @param [Symbol] name The name of the setting.
    # @param [Symbol] block The block to be executed when the setting is called.
    # @raise [Errors::DuplicateSetting] If there is already a setting defined with that name.
    #
    # @return [Symbol] The name of the setting
    #
    # @api public
    #
    def add_setting(name, &block)
      validate_setting_existence(name)
      define_singleton_method(name, block)
    end

    private

    # Checks if there is a setting already defined with the given +setting_name.
    def validate_setting_existence(setting_name)
      error_message = "There is already a setting defined with the name #{setting_name}"
      raise Errors::DuplicateSetting, error_message if respond_to?(setting_name)
    end

    # Checks if the snapshot record mode is one of the modes declared in +VALID_SNAPSHOT_RECORD_MODES+.
    def validate_record_mode(record_mode)
      raise Errors::InvalidRecordMode unless VALID_SNAPSHOT_RECORD_MODES.include?(record_mode.to_sym)
    end

    # Checks if the snapshot extension is valid.
    def validate_snapshot_extension(snapshot_extension)
      raise Errors::InvalidSnapshotExtension unless snapshot_extension =~ /^[a-zA-Z0-9]+$/
    end
  end
end

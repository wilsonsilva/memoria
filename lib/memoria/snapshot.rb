module Memoria
  # Stores the snapshot details.
  class Snapshot
    # Returns the name of the snapshot. Each snapshot should have a unique name.
    #
    # @example
    #   snapshot = Snapshot.new('listing-all-users')
    #   snapshot.name #=> 'listing-all-users'
    #
    # @return [String] The name of the snapshot.
    #
    # @api public
    #
    attr_reader :name

    # Creates a new snapshot.
    #
    # @example
    #   snapshot = Snapshot.new('listing-all-users')
    #
    # @return [Snapshot] An instance of +Snapshot+.
    #
    # @api public
    #
    def initialize(name)
      @name = name
    end
  end
end

module Memoria
  module Errors
    # Raised when the snapshot extension doesn't follow a file naming pattern.
    class InvalidSnapshotExtension < InvalidConfiguration
      # The generic message of the exception.
      #
      # @return [String] Exception's message.
      #
      # @api public
      #
      def message
        'The snapshot extension is invalid.'
      end
    end
  end
end

module Memoria
  module Errors
    # Raised when the record mode isn't one of +all+, +none+ or +new_snapshots+.
    class InvalidRecordMode < InvalidConfiguration
      # The generic message of the exception.
      #
      # @return [String] Exception's message.
      #
      # @api public
      #
      def message
        'The snapshot record mode is invalid. The only valid modes are :all, :none and :new_snapshots.'
      end
    end
  end
end

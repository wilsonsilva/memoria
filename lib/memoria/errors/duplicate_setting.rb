module Memoria
  module Errors
    # Raised when attempting to add a setting that already exists.
    class DuplicateSetting < InvalidConfiguration
      # The generic message of the exception.
      #
      # @return [String] Exception's message.
      #
      # @api public
      #
      def message
        "There's already a setting with that name."
      end
    end
  end
end

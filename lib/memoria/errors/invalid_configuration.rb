module Memoria
  module Errors
    # Raised when the configuration is invalid. This is a parent class to all the other classes.
    class InvalidConfiguration < RuntimeError
      # The generic message of the exception.
      #
      # @return [String] Exception's message.
      #
      # @api public
      #
      def message
        "Memoria's configuration is invalid."
      end
    end
  end
end

module Memoria
  module RSpec
    # Provides methods to retrieve RSpec's example metadata
    module Metadata
      # Retrieve the metadata from the current example
      #
      # @api private
      #
      # @return [Hash] RSpec's metadata of the current example.
      #
      def current_example_metadata
        self.class.metadata
      end
    end
  end
end

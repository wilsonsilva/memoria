module Memoria
  module RSpec
    # Extracts information from RSpec's examples metadata.
    module MetadataParser
      extend self

      # Finds RSpec's description of a given example's metadata.
      #
      # @param [Hash] metadata RSpec's metadata of a given example.
      #
      # @return [String]
      #
      # @api private
      #
      def find_description_for(metadata)
        description = find_description_in(metadata)
        example_group = find_example_group_in(metadata)

        if example_group
          [find_description_for(example_group), description].join('/')
        else
          description
        end
      end

      private

      # Finds an RSpec description in a given metadata.
      #
      # @param [Hash] metadata RSpec's metadata
      #
      # @return [String] The description of an RSpec example
      #
      def find_description_in(metadata)
        metadata[:description].empty? ? metadata[:scoped_id] : metadata[:description]
      end

      # Finds an RSpec example group in a given metadata.
      #
      # @param [Hash] metadata RSpec's metadata
      #
      # @return [Hash] The metadata of an RSpec example group
      #
      def find_example_group_in(metadata)
        metadata.key?(:example_group) ? metadata[:example_group] : metadata[:parent_example_group]
      end
    end
  end
end

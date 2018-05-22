require 'memoria/rspec/metadata'
require 'memoria/rspec/metadata_parser'

module Memoria
  module RSpec
    # Configures the integration with RSpec.
    module Configurator
      module_function

      # Configures RSpec's +before+ and +after+ hooks to record snapshots when  +match_snapshot+ is called.
      #
      # @return [void]
      #
      # @api private
      #
      def configure_rspec_hooks
        ::RSpec.configure do |config|
          config.before(:each, snapshot: true) do |example|
            current_example = example.respond_to?(:metadata) ? example : example.example
            snapshot_name   = Memoria::RSpec::MetadataParser.find_description_for(current_example.metadata)

            Memoria.record(snapshot_name)
          end

          config.after(:each, snapshot: true) do
            Memoria.stop_recording
          end
        end
      end

      # Includes RSpec's matchers such as +match_snapshot+.
      #
      # @return [void]
      #
      # @api private
      #
      def include_rspec_matchers
        require 'memoria/rspec/matcher'

        ::RSpec.configure do |config|
          config.include Memoria::RSpec::Metadata
        end
      end
    end
  end
end

require 'memoria'
require 'memoria/rspec/configurator'

Memoria.configure do |config|
  config.add_setting(:configure_rspec_hooks) do
    Memoria::RSpec::Configurator.configure_rspec_hooks
  end

  config.add_setting(:include_rspec_matchers) do
    Memoria::RSpec::Configurator.include_rspec_matchers
  end

  config.snapshot_directory = 'spec/fixtures/snapshots' unless config.snapshot_directory.nil?
end

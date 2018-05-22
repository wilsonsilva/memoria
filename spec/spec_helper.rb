require 'bundler/setup'
require 'simplecov'
require 'simplecov-console'
require 'pry'

SimpleCov.formatter = SimpleCov::Formatter::Console
SimpleCov.start do
  root 'lib'
  coverage_dir Dir.pwd + '/coverage'
end

require 'memoria'
require 'memoria/rspec'
require 'support/test_helpers/file_system'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include TestHelpers::FileSystem
end

Memoria.configure do |config|
  config.snapshot_directory = 'spec/fixtures'
  config.configure_rspec_hooks
  config.include_rspec_matchers
end

RSpec.describe 'RSpec integration with Memoria' do
  let(:configuration) { Memoria::Configuration.new }

  before do
    allow(Memoria).to receive(:configuration).and_return(configuration)
  end

  it 'adds a setting to configure RSpec hooks' do
    allow(Memoria::RSpec::Configurator).to receive(:configure_rspec_hooks)
    load 'lib/memoria/rspec.rb'
    configuration.configure_rspec_hooks
    expect(Memoria::RSpec::Configurator).to have_received(:configure_rspec_hooks)
  end

  it 'adds a setting to include RSpec matchers' do
    allow(Memoria::RSpec::Configurator).to receive(:include_rspec_matchers)
    load 'lib/memoria/rspec.rb'
    configuration.include_rspec_matchers
    expect(Memoria::RSpec::Configurator).to have_received(:include_rspec_matchers)
  end
end

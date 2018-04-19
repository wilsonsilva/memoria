
lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'memoria/version'

Gem::Specification.new do |spec|
  spec.name          = 'memoria'
  spec.version       = Memoria::VERSION
  spec.authors       = ['Wilson Silva']
  spec.email         = ['wilson.dsigns@gmail.com']

  spec.summary       = 'Jest-like snapshot testing.'
  spec.description   = 'Capture snapshots to simplify testing and to analyze how state changes over time.'
  spec.homepage      = 'https://github.com/wilsonsilva/memoria'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'bundler-audit', '~> 0.6'
  spec.add_development_dependency 'overcommit', '~> 0.45'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.55'
  spec.add_development_dependency 'rubocop-rspec', '~> 1.25'
end

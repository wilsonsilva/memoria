# Memoria

[![Gem Version](https://badge.fury.io/rb/memoria.svg)](http://badge.fury.io/rb/memoria)
[![Build Status](https://travis-ci.org/wilsonsilva/memoria.svg?branch=master)](https://travis-ci.org/wilsonsilva/memoria)
[![Dependency Status](https://gemnasium.com/wilsonsilva/memoria.svg)](https://gemnasium.com/wilsonsilva/memoria)
[![security](https://hakiri.io/github/wilsonsilva/memoria/master.svg)](https://hakiri.io/github/wilsonsilva/memoria/master)
[![Inline docs](http://inch-ci.org/github/wilsonsilva/memoria.svg?branch=master)](http://inch-ci.org/github/wilsonsilva/memoria)

Asserts the result of a given test by generating a rendered representation of its output. Inspired by Jest and VCR.

The first time your test is run, a representation of your expected output is saved to a file. The next time you
run the same test, a diff runs between a new and the previously stored snapshot. If there are no differences the test
passes, otherwise the test fails and the resulting diff is displayed.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'memoria'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install memoria

## Usage

### RSpec

You can configure RSpec's integration in `spec_helper.rb`. Require `memoria/rspec` then run `Memoria.configure`:

```ruby
Memoria.configure do |config|
  config.configure_rspec_hooks
  config.include_rspec_matchers
end
```

The configuration above does two things:
- Includes the matcher `match_snapshot` in your RSpec test suite.
- Configures RSpec hooks to create snapshots named after the full spec example's description.

Use the provided matcher `match_snapshot` to verify if the expected output matches a previously recorded snapshot.

```ruby
expect(view).to match_snapshot
```

By default the snapshots will be stored in `spec/fixtures/snapshots`, but you can change this with the setting
`snapshot_directory`:

```ruby
Memoria.configure do |config|
  config.snapshot_directory = 'spec/snapshots'
end
```

### Cucumber
Under development.

### Minitest
Under development.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can
also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the
version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version,
push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

### Architecture

Memoria was designed using a modular plugin architecture. The core part of the gem has a single responsibility:
manage snapshots. Every test framework integration is done through a self-contained plugin. Plugins depend on the core,
but the core is unaware of the plugins. This allows me to extract the plugins into their own gems later, and
add new plugins with ease.

![Class Diagram](https://github.com/wilsonsilva/memoria/blob/master/documentation/class-diagram.svg)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/wilsonsilva/memoria.

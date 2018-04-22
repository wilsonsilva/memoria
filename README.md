# Memoria

[![Gem Version](https://badge.fury.io/rb/memoria.svg)](http://badge.fury.io/rb/memoria)
[![Build Status](https://travis-ci.org/wilsonsilva/memoria.svg?branch=master)](https://travis-ci.org/wilsonsilva/memoria)
[![Dependency Status](https://gemnasium.com/wilsonsilva/memoria.svg)](https://gemnasium.com/wilsonsilva/memoria)
[![security](https://hakiri.io/github/wilsonsilva/memoria/master.svg)](https://hakiri.io/github/wilsonsilva/memoria/master)

Asserts the result of a given test by generating a rendered representation of its output. Inspired by Jest.

The first time your test is run, a representation of your expected output is saved to a file. The next time you
run the same test, a diff runs between a new and the previously stored snapshot. If there are no differences the test
passes, otherwise the test fails and the resulting diff is returned.

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
Use the provided matcher `match_snapshot` to verify if the expected output matches a previously recorded snapshot.

```ruby
expect(view).to match_snapshot
```

By default the snapshots will be stored in `spec/fixtures/snapshots`, but you can change this with the setting
`snapshot_directory`:

```ruby
RSpec.configure do |config|
  config.snapshot_directory = 'spec/fixtures/snapshots'
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can
also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the
version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version,
push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/wilsonsilva/memoria.

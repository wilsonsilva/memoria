# Memoria

[![Gem Version](https://badge.fury.io/rb/memoria.svg)](https://badge.fury.io/rb/memoria)
![Build Status](https://github.com/wilsonsilva/memoria/actions/workflows/main.yml/badge.svg)
[![Maintainability](https://api.codeclimate.com/v1/badges/ffa08ae5daf70c87c68f/maintainability)](https://codeclimate.com/github/wilsonsilva/memoria/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/ffa08ae5daf70c87c68f/test_coverage)](https://codeclimate.com/github/wilsonsilva/memoria/test_coverage)
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

### 1. Configure `spec_helper.rb`:

```ruby
require 'memoria/rspec'

Memoria.configure do |config|
  config.configure_rspec_hooks
  config.include_rspec_matchers
end
```

The configuration above does two things:
- Configures RSpec hooks to create snapshots named after the full spec example's description.
- Includes the matcher `match_snapshot` in your RSpec test suite.

### 2. Add snapshot metadata to your test

Add `snapshot: true` to any `describe`, `context` or `it` block to generate a snapshot for that test then use the
provided matcher `match_snapshot` to verify if the expected output matches a previously recorded snapshot.

```ruby
RSpec.describe Calendario::Calendar do
  let(:calendar) { described_class.new }

  describe '#render_january' do
    it 'renders the month of January', snapshot: true do
      rendered = calendar.render_january
      expect(rendered.to_s).to match_snapshot
    end
  end
end
```

### 3. Generate the snapshot

Run the tests to generate the snapshot:

```
bundle exec rspec

Calendario::Calendar
  renders the month of january
    Generated snapshot: Calendario::Calendar/renders the month of January <--- NOTICE THIS LINE

Finished in 0.02001 seconds (files took 0.22817 seconds to load)
1 example, 0 failures
```

The tests will pass and the snapshot will be stored in a `snap` file:
`spec/fixtures/snapshots/Calendario_Calendar/_render_january/renders_the_month_of_january.snap`:

```
      January
Su Mo Tu We Th Fr Sa
          1  2  3  4
 5  6  7  8  9 10 11
12 13 14 15 16 17 18
19 20 21 22 23 24 25
26 27 28 29 30 31
```

### 4. Compare the output with the snapshot

Run the tests again to compare the output with the snapshot. The tests will pass again:

```
bundle exec rspec

Calendario::Calendar
  renders the month of january

Finished in 0.02103 seconds (files took 0.21164 seconds to load)
1 example, 0 failures
```

### Configuring the snapshot directory

By default the snapshots will be stored in `spec/fixtures/snapshots`, but you can change this with the setting
`snapshot_directory`:

```ruby
Memoria.configure do |config|
  config.snapshot_directory = 'spec/snapshots'
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive
prompt that will allow you to experiment. The health and maintainability of the codebase is ensured through a set of
Rake tasks to test, lint and audit the gem for security vulnerabilities and documentation:

```
rake bundle:audit          # Checks for vulnerable versions of gems
rake qa                    # Test, lint and perform security and documentation audits
rake rubocop               # Lint the codebase with RuboCop
rake rubocop:auto_correct  # Auto-correct RuboCop offenses
rake spec                  # Run RSpec code examples
rake verify_measurements   # Verify that yardstick coverage is at least 100%
rake yard                  # Generate YARD Documentation
rake yard:junk             # Check the junk in your YARD Documentation
rake yardstick_measure     # Measure docs in lib/**/*.rb with yardstick
```

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the
version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version,
push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

### Architecture

Martin Fowler defines software architecture as those decisions which are both important and hard to change. Since these
decisions are hard to change, we need to be sure that our foundational priorities are well-served by these decisions.

Memoria was designed using a modular plugin architecture. The core part of the gem has a single responsibility:
manage snapshots. Every test framework integration is done through a self-contained plugin. Plugins depend on the core,
but the core is unaware of the plugins. This allows me to extract the plugins into their own gems later, and
add new plugins with ease.

![Class Diagram](https://github.com/wilsonsilva/memoria/blob/main/documentation/class-diagram.svg)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/wilsonsilva/memoria.

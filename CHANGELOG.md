# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [0.2.0]
### Added
- Added a `qa` Rake task to test, lint, perform a security audit and an assessment of the documentation coverage.
- Setup overcommit git hooks when executing `bin/setup`.

### Changed
- Removed the Snapshot interface from the class diagram.
- Documented the available code maintenance Rake tasks.
- Documented how to record and use snapshots

### Fixed
- Fixed a bug that prevented snapshots from being created when `config.snapshot_directory` wasn't set explicitly.

## [0.1.0] - 2018-05-23
### Added
- Initial core functionality
- Codebase maintenance tools
- RSpec integration

[0.2.0]: https://github.com/wilsonsilva/memoria/compare/v0.1.0...0.2.0
[0.1.0]: https://github.com/wilsonsilva/memoria/compare/root...v0.1.0

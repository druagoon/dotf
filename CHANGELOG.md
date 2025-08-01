<!-- markdownlint-disable MD024 MD033 -->
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.4.0] - 2025-04-14

### Added

- *(ci)* Use `shinc` building system ([097c5c3](https://github.com/druagoon/dotf/commit/097c5c3b605d38e40ff4bce93d0fc8b41928c640))
- *(mac)* Add beyond-compare command to manage Beyond Compare trial reset ([7df6593](https://github.com/druagoon/dotf/commit/7df6593bed68bd140c2e81e0600915be917b89a6))
- *(mac)* Add cleanmymac command to manage CleanMyMac health monitor ([860b877](https://github.com/druagoon/dotf/commit/860b877200e6e9054772abff1c7511e0aeb3bc70))
- *(mac)* Add utilities and scanfiles command for macOS ([fc6c859](https://github.com/druagoon/dotf/commit/fc6c859b9d276b2a2dfff91bbe47f1c1ee80473a))

## [1.3.1] - 2025-03-07

### Added

- *(download)* Add silent mode option and progress feedback for downloads ([2ae2073](https://github.com/druagoon/dotf/commit/2ae20735e8a72b5cb782d3002ed1b98819ab6f97))

### Fixed

- *(argcfile)* Remove debug echo statement from _argc_before hook ([dd22ca3](https://github.com/druagoon/dotf/commit/dd22ca33e84cfede1f402be8114cca9dfa1db444))
- *(hooks)* Handle unset argc_debug variable in _argc_before function ([5a698d5](https://github.com/druagoon/dotf/commit/5a698d5bc5ae312e15764becb17c7d9c446d5a99))
- *(std)* Normalize boolean input handling in is_true and is_false functions ([9d237b6](https://github.com/druagoon/dotf/commit/9d237b683f60bee8a1785fc633eb006e09905f28))

### Refactor

- *(github)* Improve output formatting in link command ([1b198d8](https://github.com/druagoon/dotf/commit/1b198d888c119503c8b5c006a24002148fb6fb19))

## [1.3.0] - 2025-03-05

### Added

- *(ci)* Validate version format before creating a tag ([5728746](https://github.com/druagoon/dotf/commit/5728746b823693f60732949b9779def465b4cccd))
- *(github)* Add commands for managing GitHub repositories and linking URLs ([628e5e0](https://github.com/druagoon/dotf/commit/628e5e0fdb6c9ab3637557eb1e2ff45aca65dced))
- *(main)* Enable pipefail option for improved error handling ([6aa4861](https://github.com/druagoon/dotf/commit/6aa4861c71b17513e0d4516565b42a523f689397))
- *(package)* The `package new` command supports multiple plugin names ([c4fc41d](https://github.com/druagoon/dotf/commit/c4fc41d2be71bd6c9ebe60211f062dc1ae858b2a))

### Refactor

- *(link)* Simplify linking logic and improve package exclusion handling ([2622a72](https://github.com/druagoon/dotf/commit/2622a72f3d242b0000eacc5e9eeb70a19173e15d))

## [1.2.0] - 2025-03-03

### Added

- *(build)* Synchronize and update the version number of Argcfile.sh during the pre-release phase ([7e7f6ba](https://github.com/druagoon/dotf/commit/7e7f6bace7a40ee6d42d33b0f9ab952db0b5eac2))
- *(clipboard)* Add clipboard management and parsing commands ([a2af31a](https://github.com/druagoon/dotf/commit/a2af31ab0228580eeb15c523d92686dd11819ace))
- *(download)* Add download command using `curl` ([8fe60cd](https://github.com/druagoon/dotf/commit/8fe60cd997bfdc9d93c6765dbf5c3442566f23db))
- *(main)* Add debug mode flag and enable debug output ([3d3a4ba](https://github.com/druagoon/dotf/commit/3d3a4ba0fd585d86fd067d8205630ed77a98bb04))
- *(man)* Add man pages for dotf commands with debug option ([527c8aa](https://github.com/druagoon/dotf/commit/527c8aa8eb8b38a2754c75e182da0e600a32ca69))

## [1.1.0] - 2025-02-25

### Added

- *(brewfile)* Add confirmation message after generating Brewfile ([c2ed967](https://github.com/druagoon/dotf/commit/c2ed9670976a8e689d4b02cbf514f232f807eeb0))
- *(build)* Enhance Argcfile.sh with improved build and distribution processes ([15c3d9e](https://github.com/druagoon/dotf/commit/15c3d9ee29093208682976237e61ec6d67f258c1))
- *(ci)* Add Homebrew formula update step to release workflow ([49d8392](https://github.com/druagoon/dotf/commit/49d8392279374abf3d2e12c49290f7c022e029e9))
- *(completion)* Add confirmation message for Golang completions installation ([708b4af](https://github.com/druagoon/dotf/commit/708b4af941d73e3593c948580d29f915ad428334))
- *(path)* Enhance ensure functions to accept multiple arguments ([eb689d3](https://github.com/druagoon/dotf/commit/eb689d30b70b4b110aae0007a6f35914c55751d2))

### Changed

- *(layout)* Change the layout file export/import format ([158f7d5](https://github.com/druagoon/dotf/commit/158f7d5b35531033144df53f4eb71d748d2d10a6))
- *(package)* Update new.sh to support optional plugin prefix for oh-my-zsh plugins ([8eedaba](https://github.com/druagoon/dotf/commit/8eedabaa341dd2c98951bb2f770af330c43419db))
- *(path)* Update ensure_dir to handle multiple directories ([2bd87ba](https://github.com/druagoon/dotf/commit/2bd87ba1b46ba5be6efa3f6a5ba7ce94dc1eeb4f))

### Fixed

- *(completion)* Use `curl` instead of `wget` for downloading golang completions ([1409e76](https://github.com/druagoon/dotf/commit/1409e76a697e9849feeed8481d17c47fd5dae1b0))

### Refactor

- *(cmd)* Rename check function to exists for clarity ([bcb48b5](https://github.com/druagoon/dotf/commit/bcb48b5d4c2a969064dd5c28daa96f19c89ecf58))
- *(completion)* Remove unused icli completion script ([cc1b9b9](https://github.com/druagoon/dotf/commit/cc1b9b9114968e52f1cf9ef6812a81f82d99848c))
- *(consts)* Rename `DOTF` variables to `DF` for consistency ([06192ea](https://github.com/druagoon/dotf/commit/06192eaa9448031ebfd5406f1857fe20385a5c85))

## [1.0.0] - 2025-02-21

### Added

- *(ci)* Add github workflows ([6af9de6](https://github.com/druagoon/dotf/commit/6af9de650f0455be28ca5ea4ba89a4e102b99af7))

### Changed

- *(build)* Update Argcfile.sh and rewrite the build system using pure bash ([3e1ceb6](https://github.com/druagoon/dotf/commit/3e1ceb622dfb7bf233d2c760423a99964c621c2d))

[1.4.0]: https://github.com/druagoon/dotf/compare/v1.3.1..v1.4.0
[1.3.1]: https://github.com/druagoon/dotf/compare/v1.3.0..v1.3.1
[1.3.0]: https://github.com/druagoon/dotf/compare/v1.2.0..v1.3.0
[1.2.0]: https://github.com/druagoon/dotf/compare/v1.1.0..v1.2.0
[1.1.0]: https://github.com/druagoon/dotf/compare/v1.0.0..v1.1.0
[1.0.0]: https://github.com/druagoon/dotf/releases/tag/v1.0.0

<!-- generated by git-cliff -->

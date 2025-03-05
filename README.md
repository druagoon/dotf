<!-- markdownlint-disable MD033 MD036 -->
<h1>dotf</h1>

Lightweight and flexible CLI tool written in Bash for managing dotfiles efficiently.

**Table of Contents**

- [Installation](#installation)
- [Development](#development)
  - [Pre-release](#pre-release)
- [Changelog](#changelog)

## Installation

You can install `dotf` using Homebrew:

```sh
brew install druagoon/brew/dotf
```

Or download the binary directly from [GitHub Releases](https://github.com/druagoon/dotf/releases).

## Development

### Pre-release

To create a new release:

Run the pre-release command with the new version:

```sh
argc prerelease <version>
```

This will:

- Update version in `Argcfile.sh`
- Update `CHANGELOG.md` using `cliff.toml` configuration by `git-cliff`
- Create a git tag

Then the release workflow will automatically:

- Build the binaries
- Create a GitHub release
- Update the Homebrew formula

## Changelog

See [CHANGELOG.md](./CHANGELOG.md).

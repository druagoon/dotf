<!-- markdownlint-disable MD033 MD036 -->
<h1>dotf</h1>

Lightweight and flexible CLI tool written in Bash for managing dotfiles efficiently.

**Table of Contents**

- [Installation](#installation)
- [Development](#development)
  - [Release](#release)
- [Changelog](#changelog)

## Installation

You can install `dotf` using Homebrew:

```sh
brew install druagoon/brew/dotf
```

Or download the binary directly from [GitHub Releases](https://github.com/druagoon/dotf/releases).

## Development

### Release

To create a new release:

Run the `shinc release` command with the new version:

```sh
shinc release <version>
```

This will:

- Update version in `.config/shinc/config.toml`
- Update `CHANGELOG.md` using `cliff.toml` configuration by `git-cliff`
- Commit changes
- Create a git tag
- Push to git remote

Then the release workflow will automatically:

- Build the binaries
- Create a GitHub release
- Update the Homebrew formula

## Changelog

See [CHANGELOG.md](./CHANGELOG.md).

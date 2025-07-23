<!-- markdownlint-disable MD033 MD036 -->
<h1>dotf</h1>

Lightweight and flexible CLI tool written in Bash for managing dotfiles efficiently.

**Table of Contents**

- [Installation](#installation)
  - [Homebrew](#homebrew)
  - [Pre-built Binaries](#pre-built-binaries)
- [Development](#development)
  - [Dependencies](#dependencies)
  - [Release](#release)
- [Changelog](#changelog)

## Installation

### Homebrew

```sh
brew install druagoon/brew/dotf
```

### Pre-built Binaries

Alternatively, download pre-built binaries from [GitHub Releases](https://github.com/druagoon/dotf/releases),
then extract it, and add the `dotf` binary to your `$PATH`.

You can use the following command to download the latest release.

```sh
curl -fsSL https://github.com/druagoon/dotf/raw/master/install.sh | bash -s
```

Or see more help.

```sh
curl -fsSL https://github.com/druagoon/dotf/raw/master/install.sh | bash -s -- --help
```

## Development

### Dependencies

- [shinc](https://github.com/druagoon/shinc-rs)

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

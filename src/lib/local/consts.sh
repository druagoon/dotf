# Global
DF_ROOT="${DOTFILES_ROOT:-${HOME}/.dotfiles}"
DF_PKG_ROOT="${DF_ROOT}/packages"

## Plugin
DF_OMZ_PLUGIN_PREFIX="dotf-"

dotf::pkg::dir::get() {
    local name="$1"
    echo "${DF_PKG_ROOT}/${name}"
}

dotf::pkg::completions::dir() {
    local name="$1"
    local pkg_dir="$(dotf::pkg::dir::get "${name}")"
    echo "${pkg_dir}/.oh-my-zsh/custom/completions"
}

## OS
DF_OS_LAYOUT_DIR="$(dotf::pkg::dir::get "os/layouts")"

## Link
DF_LINK_STOW_SRC="${DF_PKG_ROOT}"
DF_LINK_STOW_TARGET="${HOME}"
DF_LINK_EXCLUDE_PKG=(.git .venv .vscode)
DF_LINK_EXCLUDE_PKG_STRING="$(
    IFS=":"
    echo "${DF_LINK_EXCLUDE_PKG[*]}"
)"

## Brew
DF_PKG_BREW_DIR="$(dotf::pkg::dir::get brew)"

## Git
DF_PKG_GIT_DIR="$(dotf::pkg::dir::get git)"

## Go
DF_PKG_GO_DIR="$(dotf::pkg::dir::get go)"

## iCli
DF_PKG_ICLI_DIR="$(dotf::pkg::dir::get icli)"

## Rust
DF_PKG_RUST_DIR="$(dotf::pkg::dir::get rust)"

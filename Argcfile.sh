#!/usr/bin/env bash

# @describe Manage `dotf` project
# @meta version 1.3.1
# @meta require-tools awk,sed,shfmt
# @meta inherit-flag-options
# @flag -D --debug Enable debug mode

set -e

# Project
NAME="dotf"
VERSION="1.3.1"
TAG="v${VERSION}"

# BASE_DIR="$(cd "$(dirname "$(realpath "${BASH_SOURCE[0]}")")" >/dev/null 2>&1 && pwd)"
BASE_DIR="${ARGC_PWD}"
CONTRIB_DIR="${BASE_DIR}/contrib"
COMP_DIR="${CONTRIB_DIR}/completions"
MAN_DIR="${CONTRIB_DIR}/man"
MAN1_DIR="${MAN_DIR}/man1"

SRC_DIR="${BASE_DIR}/src"
SRC_MAIN="${SRC_DIR}/main.sh"
BUILD_DIR="${BASE_DIR}/build"
BUILD_TARGET="${BUILD_DIR}/${NAME}.sh"
BIN_DIR="${BASE_DIR}/bin"
BIN_TARGET="${BIN_DIR}/${NAME}"
DIST_DIR="${BASE_DIR}/dist"

# Define the path to the AWK script used for shell inclusion.
# The script is located in the base directory and is named 'shinc.awk'.
SHINC_AWK="${BASE_DIR}/shinc.awk"

# Tools
SHFMT_OPTS="-ln=auto -i 4 -ci -bn -w"

OS="$(uname)"
if [[ "${OS}" == "Darwin" ]]; then
    SED="gsed"
elif [[ "${OS}" == "Linux" ]]; then
    SED="sed"
else
    echo "Unsupported OS: ${OS}" >&2
    exit 1
fi

debug() {
    printf "\033[35m==>\033[0m \033[1m%s\033[0m\n" "$*"
}

hai() {
    printf "  \033[34m==>\033[0m \033[1m%s\033[0m\n" "$*"
}

ensure_dir() {
    for dir in "$@"; do
        if [[ ! -d "${dir}" ]]; then
            mkdir -p "${dir}"
        fi
    done
}

fmt_shell() {
    shfmt ${SHFMT_OPTS} "$@"
}

generate_completions() {
    argc --argc-completions bash "${NAME}" >"${COMP_DIR}/bash/${NAME}"
    argc --argc-completions fish "${NAME}" >"${COMP_DIR}/fish/${NAME}.fish"
    local comp_zsh="${COMP_DIR}/zsh/_${NAME}"
    argc --argc-completions zsh "${NAME}" >"${comp_zsh}"
    # Detect and insert the `#compdef` line if it doesn't exist for zsh completions autoloading
    ${SED} -i '1{/^#compdef /!i\
#compdef argc '"${NAME}"'\n
}' "${comp_zsh}"
}

generate_man_pages() {
    argc --argc-mangen "${BUILD_TARGET}" "${MAN1_DIR}"
}

# @cmd Format shell scripts
fmt() {
    return
}

# @cmd Format shell scripts in `./src`
fmt::src() {
    fmt_shell "${SRC_DIR}"
}

# @cmd Format shell scripts in current directory
fmt::all() {
    fmt_shell .
}

# @cmd TOML files tools
# @meta require-tools taplo
toml() {
    return
}

# @cmd Format all TOML files
toml::format() {
    taplo format
}

# @cmd Check all TOML files
toml::check() {
    taplo format --check
}

# @cmd Compile and build binaries
build() {
    debug "Building ${NAME}"

    hai "Format sources: ${SRC_DIR}"
    fmt::src

    cd "${SRC_DIR}" || exit
    ensure_dir "${BUILD_DIR}" "${BIN_DIR}"
    hai "Compile source: ${SRC_MAIN} -> ${BUILD_TARGET}"
    awk -v version="${VERSION}" -f "${SHINC_AWK}" "${SRC_MAIN}" >"${BUILD_TARGET}"
    chmod +x "${BUILD_TARGET}"
    fmt_shell "${BUILD_TARGET}"

    hai "Argc build: ${BUILD_TARGET} -> ${BIN_TARGET}"
    argc --argc-build "${BUILD_TARGET}" "${BIN_TARGET}"
    fmt_shell "${BIN_TARGET}"
    chmod +x "${BIN_TARGET}"

    hai "Generate shell completions"
    generate_completions

    hai "Generate man pages"
    generate_man_pages
}

# @cmd Test binaries
test() {
    debug "Testing ${NAME}"

    ${BIN_TARGET} --version
}

# @cmd Pre-release (bump version, update CHANGELOG, and create a tag)
# @meta require-tools git
# @arg version!                 Version number
prerelease() {
    debug "Pre-release ${NAME}"

    local version="${argc_version}"
    if [[ ! "${version}" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        echo "Invalid version: ${version}" >&2
        exit 1
    fi

    local tag="v${version}"
    if git rev-parse "${tag}" >/dev/null 2>&1; then
        echo "tag already exists: ${tag}" >&2
        exit 1
    fi

    hai "Version: ${version}"
    hai "Tag: ${tag}"
    hai "Update version"
    local argc_file="Argcfile.sh"
    ${SED} -i -E \
        -e 's/^(VERSION)="[0-9]+\.[0-9]+\.[0-9]+"$/\1="'"${version}"'"/' \
        -e 's/^(# @meta version )[0-9]+\.[0-9]+\.[0-9]+$/\1'"${version}"'/' \
        "${argc_file}"
    git add "${argc_file}"

    hai "Update CHANGELOG"
    local changelog="CHANGELOG.md"
    git cliff -o "${changelog}" -t "${tag}"

    hai "Commit and tag"
    git add "${changelog}"
    git commit -m "chore: Release ${tag}"
    git tag -a -m "chore: Release ${tag}" "${tag}"
}

# @cmd Distribute binaries
dist() {
    debug "Distribute ${NAME}"

    if [[ ! -f ${BIN_TARGET} ]]; then
        echo "Binary not found: ${BIN_TARGET}" >&2
        exit 1
    fi

    ensure_dir "${DIST_DIR}"
    local name="${NAME}-${TAG}.tar.gz"
    local fullname="${DIST_DIR}/${name}"
    hai "Archive to: ${fullname}"
    tar -cvzf "${fullname}" README.md LICENSE bin/ contrib/

    local checksum="${DIST_DIR}/${name}.sha256"
    hai "Generate sha256sum: ${checksum}"
    cd "${DIST_DIR}" && sha256sum "${name}" >"${checksum}"
}

# @cmd Clean up
clean() {
    debug "Clean up"

    local -a dirs=(
        "${BIN_DIR}"
        "${BUILD_DIR}"
        "${DIST_DIR}"
    )
    rm -rf "${dirs[@]}"
}

# Hooks
_argc_before() {
    if [[ "${argc_debug}" == "1" ]]; then
        set -x
    fi
}

# See more details at https://github.com/sigoden/argc
eval "$(argc --argc-eval "$0" "$@")"

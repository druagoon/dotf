#!/usr/bin/env bash

# @describe Manage `dotf` project
# @meta require-tools awk,sed,shfmt

set -e

# Project
NAME="dotf"
VERSION="1.0.0"
TAG="v${VERSION}"

# BASE_DIR="$(cd "$(dirname "$(realpath "${BASH_SOURCE[0]}")")" >/dev/null 2>&1 && pwd)"
BASE_DIR="${ARGC_PWD}"
CONTRIB_DIR="${BASE_DIR}/contrib"
COMP_DIR="${CONTRIB_DIR}/completions"

SRC_DIR="${BASE_DIR}/src"
SRC_MAIN="${SRC_DIR}/main.sh"
BUILD_DIR="${BASE_DIR}/build"
BUILD_TARGET="${BUILD_DIR}/${NAME}.sh"
DIST_DIR="${BASE_DIR}/dist"
DIST_TARGET="${DIST_DIR}/${NAME}"

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
    # Format the shell scripts in the source directory before building
    fmt::src

    # Compile source
    cd "${SRC_DIR}" || exit
    ensure_dir "${BUILD_DIR}" "${DIST_DIR}"
    awk -v version="${VERSION}" -f "${SHINC_AWK}" "${SRC_MAIN}" >"${BUILD_TARGET}"
    chmod +x "${BUILD_TARGET}"
    fmt_shell "${BUILD_TARGET}"

    # Build without argc dependency
    argc --argc-build "${BUILD_TARGET}" "${DIST_TARGET}"
    fmt_shell "${DIST_TARGET}"
    chmod +x "${DIST_TARGET}"

    # Generate shell completions
    generate_completions
}

# @cmd Test binaries
test() {
    ${DIST_TARGET} --version
}

# @cmd Pre-release (bump version, update CHANGELOG, and create a tag)
# @meta require-tools git
# @arg version!                 Version number
prerelease() {
    local version="${argc_version}"
    local tag="v${version}"
    if git rev-parse "${tag}" >/dev/null 2>&1; then
        echo "tag already exists: ${tag}" >&2
        exit 1
    fi
    echo "version: ${version}"
    echo "tag: ${tag}"
    local argc_file="Argcfile.sh"
    local changelog="CHANGELOG.md"
    ${SED} -i 's/^VERSION="[0-9]\+\.[0-9]\+\.[0-9]\+"$/VERSION="'"${version}"'"/' "${argc_file}"
    git add "${argc_file}"
    git cliff -o "${changelog}" -t "${tag}"
    git add "${changelog}"
    git commit -m "chore: Release ${tag}"
    git tag -a -m "chore: Release ${tag}" "${tag}"
}

# @cmd Distribute binaries
dist() {
    if [[ ! -f ${DIST_TARGET} ]]; then
        echo "Binary not found: ${DIST_TARGET}" >&2
        exit 1
    fi
    ensure_dir "${DIST_DIR}" bin
    cp -v "${DIST_TARGET}" bin/
    local name="${NAME}-${TAG}.tar.gz"
    local fullname="${DIST_DIR}/${name}"
    echo "Archive to: ${fullname}"
    tar -cvzf "${fullname}" README.md LICENSE bin/ contrib/
    rm -rf bin/
    cd "${DIST_DIR}" && sha256sum "${name}" >"${name}.sha256"
}

# @cmd Clean up
clean() {
    rm -rf "${BUILD_DIR}" "${DIST_DIR}"
}

# See more details at https://github.com/sigoden/argc
eval "$(argc --argc-eval "$0" "$@")"

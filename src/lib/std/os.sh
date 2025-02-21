std::os::is_linux() {
    [[ "$(uname)" == "Linux" ]]
}

std::os::is_macos() {
    [[ "$(uname)" == "Darwin" ]]
}

std::os::is_arm64() {
    local arch="$(uname -m)"
    [[ "${arch}" == "arm64" || "${arch}" == "aarch64" ]]
}

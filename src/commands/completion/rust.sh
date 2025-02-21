# @cmd Generate rustup and cargo completions
#
# Examples:
#   dotf completion rust
#
# @meta require-tools rustup,cargo
completion::rust() {
    local comp_dir="$(dotf::pkg::completions::dir rust)"
    std::path::dir::ensure "${comp_dir}"
    local comp_cargo="${comp_dir}/_cargo"
    local comp_rustup="${comp_dir}/_rustup"
    rustup completions zsh cargo >"${comp_cargo}"
    rustup completions zsh rustup >"${comp_rustup}"
}

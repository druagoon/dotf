# @cmd Generate icli completions
#
# Examples:
#   dotf completion icli
#
# @meta require-tools icli
completion::icli() {
    local comp_dir="$(dotf::pkg::completions::dir icli)"
    std::path::dir::ensure "${comp_dir}"
    local target="${comp_dir}/_icli"
    icli completion zsh >"${target}"
}

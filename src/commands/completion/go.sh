# @cmd Generate golang completions
#
# Examples:
#   dotf completion go
#
# @meta require-tools wget
completion::go() {
    local source="https://github.com/zsh-users/zsh-completions/raw/master/src/_golang"
    local comp_dir="$(dotf::pkg::completions::dir go)"
    std::path::dir::ensure "${comp_dir}"
    local target="${comp_dir}/_golang"
    wget -q -O "${target}" "${source}"
}

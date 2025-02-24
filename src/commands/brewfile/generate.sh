# @cmd Generate Brewfile by `brew bundle dump`
#
# Examples:
#   dotf brewfile generate
#
brewfile::generate() {
    cd "${DF_PKG_BREW_DIR}" && brew bundle dump --describe --force
}

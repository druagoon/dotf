# @cmd Generate global .gitignore file
#
# Examples:
#   dotf gitignore generate
#
# @meta require-tools gsed,git-ignore
gitignore::generate() {
    cd "${DOTF_PKG_GIT_DIR}" \
        && git-ignore -u global | gsed '1,3d' >./.gitignore_global \
        && echo >>./.gitignore_global \
        && git-ignore user | gsed '1,3d' >>./.gitignore_global
}

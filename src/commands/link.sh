# @cmd Create symbolic links for dotfiles packages
#
# Examples:
#   dotf link -- -v
#   dotf link -- -v -n
#   dotf link -- -v -n --adopt
#   dotf link --regenerate-stow-local-ignore -- -v -n
#
# @meta require-tools stow,gawk
# @flag    --regenerate-stow-local-ignore           regenerate the .stow-local-ignore file for each package
# @arg stow*                                        capture all remaining options for stow
link() {
    dotf_link_packages
}

dotf_link_stow_log() {
    local result
    if [[ $? -eq 0 ]]; then
        result="$(std::color::green_bold OK)"
    else
        result="$(std::color::red_bold ERROR)"
    fi
    printf "%-12s [ %s ]\n" "$1" "${result}"
}

dotf_link_stow_symlink() {
    local opts=("${argc_stow[@]:-}")
    stow "${opts[@]}" -d "${DF_LINK_STOW_SRC}" -t "${DF_LINK_STOW_TARGET}" "$@"
}

dotf_link_is_exclude_pkg() {
    local name="$1"
    [[ "${name}" == "stow" ]] || [[ "${name}" == "."* ]]
}

dotf_link_stow_local_ignore() {
    local name="$1"
    local pkg_dir="${DF_LINK_STOW_SRC}/${name}"
    local source="${pkg_dir}/.stow-local-ignore.inc"
    local target="${pkg_dir}/.stow-local-ignore"

    if [[ ! -f "${source}" ]]; then
        return
    fi
    if [[ -f "${target}" ]] && std::bool::is_false "${argc_regenerate_stow_local_ignore:-}"; then
        return
    fi

    gawk '
        BEGIN {
            print "### Generated at", strftime("%Y-%m-%dT%H:%M:%S%z")
        }
        {
            print $0;
            if (NF == 2 && $1 == "#include") {
                sub("~", "'"${HOME}"'", $2);
                while ((getline line < $2) > 0)
                    print line
                close($2)
            }
        }
    ' "${source}" >"${target}"
}

dotf_link_pkg() {
    local name="$1"
    dotf_link_stow_local_ignore "${name}"
    dotf_link_stow_symlink "${name}"
    dotf_link_stow_log "${name}"
}

dotf_link_packages() {
    # Link `stow` first in order to set up the .stow-local-ignore file
    dotf_link_pkg "stow"

    find "${DF_LINK_STOW_SRC}" -maxdepth 1 -mindepth 1 -type d | sort | while read -r path; do
        local name="${path##*/}"
        if ! dotf_link_is_exclude_pkg "${name}"; then
            dotf_link_pkg "${name}"
        fi
    done
}

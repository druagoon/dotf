# @cmd Sync the layout from a file
#
# Examples:
#   dotf layout sync --layout github
#   dotf layout sync --source ./github
#
# @meta require-tools git
# @option -s --source           Read layouts from the file
# @option    --layout           Read layouts from ${DF_OS_LAYOUT_DIR} directory
# @flag   -n --dry-run          Show what layouts will be export (not actually run)
layout::sync() {
    local source="${argc_source}"
    local layout="${argc_layout}"
    local dry_run="${argc_dry_run}"

    if [[ -z "${source}" ]]; then
        if [[ -n "${layout}" ]]; then
            source="${DF_OS_LAYOUT_DIR}/${layout}"
        else
            std::message::fatal "missing --source or --layout, please see --help for detail."
        fi
    fi
    if [[ ! -f "${source}" ]]; then
        std::message::fatal "'%s' not exists." "${source}"
    fi

    if std::bool::is_true "${dry_run}"; then
        std::message::warning "in simulation mode so not modifying filesystem."
    fi
    readarray -t lines <"${source}"
    set -f # avoid globbing (expansion of *).
    local path
    local url
    local msg
    for i in $(seq 1 2 ${#lines[@]}); do
        path="$(std::string::strip_whitespace "${lines[$i - 1]}")"
        path="${path/#\~/${HOME}}"
        url="$(std::string::strip_whitespace "${lines[$i]}")"
        if [[ ! -d "${path}" ]]; then
            msg="git clone '${url}' to '${path}'"
            if std::bool::is_true "${dry_run}"; then
                std::message::warning "${msg}"
            else
                echo "${msg}"
                git clone "${url}" "${path}" && echo
            fi
        fi
    done
}

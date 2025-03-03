# @cmd Import the layout from a file
#
# Examples:
#   dotf layout import --layout github.toml
#   dotf layout import --source ./github.toml
#
# @meta require-tools git,yq
# @flag   -n --dry-run          Show what layouts will be export (not actually run)
# @option -s --source           Read layouts from the file
# @option    --layout           Read layouts from ${DF_OS_LAYOUT_DIR} directory
layout::import() {
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

    local msg
    while IFS=$'\t' read -r path url; do
        path="${path/#\~/${HOME}}"
        if [[ ! -d "${path}" ]]; then
            msg="git clone '${url}' to '${path}'"
            if std::bool::is_true "${dry_run}"; then
                std::message::warning "${msg}"
            else
                echo "${msg}"
                git clone "${url}" "${path}" && echo
            fi
        fi
    done < <(yq -o=tsv '.repository[] | [.path, .url] | @tsv' "${source}")
}

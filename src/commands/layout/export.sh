# @cmd Export the layout of the local git repository to a file
#
# Examples:
#   dotf layout export ~/Code/github --layout github
#   dotf layout export ~/Code/github --output ./github
#
# @meta require-tools git
# @arg path!                            Path of the git repository
# @option -o --output <FILE>            Write layouts to file
# @option    --layout <NAME>            Write layouts to file in ${DOTF_OS_LAYOUT_DIR} directory
# @option    --max-depth=4 <NUMBER>     Maximum depth to locate git repository in the path
# @flag   -n --dry-run                  Show what layouts will be export (not actually run)
layout::export() {
    local path="${argc_path%/}"
    local output="${argc_output}"
    local layout="${argc_layout}"
    local max_depth="${argc_max_depth}"
    local dry_run="${argc_dry_run}"

    if [[ -z "${output}" ]]; then
        if [[ -n "${layout}" ]]; then
            output="${DOTF_OS_LAYOUT_DIR}/${layout}"
        else
            std::message::fatal "missing --output or --layout, please see --help for detail."
        fi
    fi

    if ! std::bool::is_true "${dry_run}"; then
        local output_dir="$(dirname "${output}")"
        mkdir -p "${output_dir}"
        # Clear layout file content
        >"${output}"
    fi

    local filedir
    local url
    local target
    local line
    if std::bool::is_true "${dry_run}"; then
        std::message::warning "in simulation mode so not modifying filesystem."
    fi
    find "${path}" -maxdepth "${max_depth}" -name ".git" ! -path '*/.local/*' | sort | while read filename; do
        filedir=$(dirname "${filename}")
        url="$(git -C "${filedir}" config --get remote.origin.url)"
        target="${filedir/#${HOME}/\~}"
        line="${target}\n    ${url}"
        if std::bool::is_true "${dry_run}"; then
            printf "${line}\n"
        else
            printf "${line}\n" >>"${output}"
        fi
    done
}

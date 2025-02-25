# @cmd Export the layout of the local git repository to a file
#
# Examples:
#   dotf layout export ~/Code/github --layout github.toml
#   dotf layout export ~/Code/github --output ./github.toml
#
# @meta require-tools git,gsed
# @arg path!                            Path of the git repository
# @option -o --output <FILE>            Write layouts to file
# @option    --layout <NAME>            Write layouts to file in ${DF_OS_LAYOUT_DIR} directory
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
            output="${DF_OS_LAYOUT_DIR}/${layout}"
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

    if std::bool::is_true "${dry_run}"; then
        std::message::warning "in simulation mode so not modifying filesystem."
    fi
    find "${path}" -maxdepth "${max_depth}" -type d -name ".git" \! -path '*/.local/*' | sort | while read filename; do
        local filedir=$(dirname "${filename}")
        local url="$(git -C "${filedir}" config --get remote.origin.url 2>/dev/null)"
        if [[ -n "${url}" ]]; then
            filedir="${filedir/#${HOME}/\~}"
            local line="[[repository]]\npath = \"${filedir}\"\nurl = \"${url}\""
            if std::bool::is_true "${dry_run}"; then
                printf "${line}\n\n"
            else
                printf "${line}\n\n" >>"${output}"
            fi
        else
            std::message::warning "No remote.origin.url found in: ${filedir}"
        fi
    done

    gsed -i '${/^$/d}' "${output}"
}

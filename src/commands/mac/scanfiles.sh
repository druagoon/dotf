# @cmd Scan files with the given name
#
# Examples:
#   dotf mac scanfiles openai
#
# @flag      --no-system                Do not scan system directories
# @flag      --exact                    Scan with exact name
# @flag   -i --case-sensitive           Scan with case sensitive
# @flag   -v --verbose                  Verbose output
# @arg name!                            The name of the file to scan
mac::scanfiles() {
    local name="${argc_name:-}"
    local -a local_dirs=(
        ~/Library
        ~/Library/Application\ Support
        ~/Library/Application\ Support/CrashReporter
        ~/Library/Caches
        ~/Library/Containers
        ~/Library/Extensions
        ~/Library/Group\ Containers
        ~/Library/LaunchAgents
        ~/Library/Preferences
        ~/Library/PreferencePanes
        ~/Library/Saved\ Application\ State
    )
    local -a sys_dirs=(
        /Library
        /Library/Application\ Support
        /Library/Caches
        /Library/Extensions
        /Library/LaunchAgents
        /Library/LaunchDaemons
        /Library/PreferencePanes
        /Library/Preferences
    )
    local -a dirs=("${local_dirs[@]}")
    if std::bool::is_false "${argc_no_system:-}"; then
        dirs+=("${sys_dirs[@]}")
    fi
    local -a opts=(-maxdepth 1)
    if std::bool::is_true "${argc_case_sensitive:-}"; then
        opts+=(-name)
    else
        opts+=(-iname)
    fi
    if std::bool::is_true "${argc_exact:-}"; then
        opts+=("${name}")
    else
        opts+=("*${name}*")
    fi
    local pad=""
    if std::bool::is_true "${argc_verbose:-}"; then
        pad="  "
    fi
    for dir in "${dirs[@]}"; do
        if [[ -d "${dir}" ]]; then
            if std::bool::is_true "${argc_verbose:-}"; then
                std::tips::info "Scanning $(std::color::cyan "${dir}")"
            fi
            find "${dir}" "${opts[@]}" 2>/dev/null | sort | gsed -e "s#^${HOME}#${pad}~#"
        fi
    done
}

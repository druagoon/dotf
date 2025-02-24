std::path::dir::ensure() {
    for dir in "$@"; do
        if [[ ! -d "${dir}" ]]; then
            mkdir -p "${dir}"
        fi
    done
}

std::path::file::ensure() {
    for file in "$@"; do
        if [[ ! -e "${file}" ]]; then
            touch "${file}"
        fi
    done
}

std::path::file::ensure_dir() {
    for file in "$@"; do
        if [[ ! -e "${file}" ]]; then
            local dir="$(dirname "$file")"
            std::path::dir::ensure "${dir}"
            touch "${file}"
        fi
    done
}

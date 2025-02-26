dotf::path::gitkeep::exists() {
    local file="$1/.gitkeep"
    [[ -f "${file}" ]]
}

dotf::path::gitkeep::ensure_dir() {
    local file
    for v in "$@"; do
        file="$v/.gitkeep"
        std::path::file::ensure_dir "${file}"
    done
}

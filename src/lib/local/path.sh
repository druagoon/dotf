dotf::path::gitkeep::exists() {
    local file="$1/.gitkeep"
    [[ -f "${file}" ]]
}

dotf::path::gitkeep::ensure_dir() {
    local file="$1/.gitkeep"
    std::path::file::ensure_dir "${file}"
}

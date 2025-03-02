# @cmd Download a file using curl
#
# Examples:
#   dotf download https://github.com/druagoon/dotf/releases/download/v1.1.0/dotf-v1.1.0.tar.gz
#   dotf download -o output/dotf-v1.1.0.tar.gz https://github.com/druagoon/dotf/releases/download/v1.1.0/dotf-v1.1.0.tar.gz
#
# @meta require-tools curl
# @option -o --output <FILE>            Write output to <FILE> instead of the remote name (If the URL has no path, the file will not be saved)
# @arg url!                             The URL to download
download() {
    local url="${argc_url}"
    local output="${argc_output}"
    if [[ -z "${output}" ]]; then
        output="${url##*/}"
        if [[ -z "${output}" ]]; then
            echo "Error: The URL has no path, the file will not be saved" && exit 1
        fi
    fi
    curl -fsSL -o "${output}" --create-dirs "${url}"
}

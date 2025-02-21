std::env::path::is_contains() {
    [[ ":${PATH}:" == *":$1:"* ]]
}

std::env::path::prepend() {
    for p in "$@"; do
        if ! std::env::path::is_contains "${p}"; then
            export PATH="${p}:${PATH}"
        fi
    done
}

std::env::path::append() {
    for p in "$@"; do
        if ! std::env::path::is_contains "${p}"; then
            export PATH="${PATH}:${p}"
        fi
    done
}

std::tips::format() {
    local c="$1"
    shift
    printf "\033[%sm==>\033[0m \033[1m%s\033[0m\n" "$c" "$*"
}

std::tips::title() {
    std::tips::format 32 "$*"
}

std::tips::debug() {
    std::tips::format 35 "$*"
}

std::tips::info() {
    std::tips::format 34 "$*"
}

std::command::check() {
    command -v "$1" >/dev/null 2>&1
}

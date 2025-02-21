std::string::strip_whitespace() {
    sed -e 's/^[[:blank:]]*//' -e 's/[[:blank:]]*$//' <<<"$1"
}

std::string::lstrip_whitespace() {
    sed -e 's/^[[:blank:]]*//' <<<"$1"
}

std::string::rstrip_whitespace() {
    sed -e 's/[[:blank:]]*$//' <<<"$1"
}

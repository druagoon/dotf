std::bool::is_true() {
    case "$1" in
        true | yes | [Yy] | on | 1)
            true
            return
            ;;
        *)
            false
            return
            ;;
    esac
}

std::bool::is_false() {
    case "$1" in
        false | no | [Nn] | off | 0 | "")
            true
            return
            ;;
        *)
            false
            return
            ;;
    esac
}

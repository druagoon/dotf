std::bool::is_true() {
    case "${1@L}" in
        true | yes | y | on | 1)
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
    case "${1@L}" in
        false | no | n | off | 0 | "")
            true
            return
            ;;
        *)
            false
            return
            ;;
    esac
}

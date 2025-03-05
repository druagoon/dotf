# @cmd Create a new dotfiles package
# @flag      --blob                 Convert the url to a blob link
# @flag      --blame                Convert the url to a blame link
# @flag      --history              Convert the url to a history link
# @flag      --copy                 Copy the converted URL to the clipboard
# @arg url                          The URL of the repository path
github::link() {
    local url="${argc_url:-"$(pbpaste)"}"
    if [[ -z "${url}" ]]; then
        echo "No URL provided" && exit 1
    fi
    local converted_url=""
    if [[ "${url}" =~ ^https://github.com/ ]]; then
        converted_url="$(gsed -E 's#https://github.com/([^/]+)/([^/]+)/(blob|blame|commits|raw|tree)/(.+)#https://raw.githubusercontent.com/\1/\2/\4#' <<<"${url}")"
    elif [[ "${url}" =~ ^https://raw.githubusercontent.com/ ]]; then
        local format="${argc_format:-"tree"}"
        if std::bool::is_true "${argc_blob:-}"; then
            format="blob"
        elif std::bool::is_true "${argc_blame:-}"; then
            format="blame"
        elif std::bool::is_true "${argc_history:-}"; then
            format="commits"
        fi
        converted_url="$(gsed -E 's#https://raw.githubusercontent.com/([^/]+)/([^/]+)/(.+)#https://github.com/\1/\2/'"${format}"'/\3#' <<<"${url}")"
    else
        echo "Invalid URL: ${url}" && exit 1
    fi
    if std::bool::is_true "${argc_copy:-}"; then
        printf "${converted_url}" | pbcopy
    fi
    printf "${url} \033[34m==>\033[0m ${converted_url}\n"
}

# @cmd Parse the clipboard content
#
# Examples:
#   dotf clipboard parse --json
#   dotf clipboard parse --base64-decode --json
#   dotf clipboard parse --base64-decode --json --copy
#   dotf clipboard parse --base64-decode --json --sort-key
#
# @meta require-tools jq,yq
# @flag      --base64-decode            Decode the clipboard content as base64
# @flag      --json                     Parse the clipboard content as JSON
# @flag      --yaml                     Parse the clipboard content as YAML
# @flag      --sort-key                 Sort the keys of the output
# @flag      --no-pretty                Do not pretty print the output
# @flag      --copy                     Copy the parsed content to the clipboard
# @option    --indent <NUMBER>          Set the number of spaces to indent the output (Only for json)
clipboard::parse() {
    local content="$(pbpaste)"
    if [[ -z "${content}" ]]; then
        echo "No content found in the clipboard" && exit 1
    fi

    if std::bool::is_true "${argc_base64_decode}"; then
        content="$(base64 -d <<<"${content}")"
    fi

    local cmd
    local -a opts=()
    if std::bool::is_true "${argc_json}"; then
        cmd=jq
        if std::bool::is_true "${argc_no_pretty}"; then
            opts+=(-c)
        fi
        if std::bool::is_true "${argc_sort_key}"; then
            opts+=(-S)
        fi
        if [[ -n "${argc_indent}" ]]; then
            opts+=(--indent "${argc_indent}")
        fi
    elif std::bool::is_true "${argc_yaml}"; then
        cmd=yq
        if std::bool::is_false "${argc_no_pretty}"; then
            opts+=(-P)
        fi
        if std::bool::is_true "${argc_sort_key}"; then
            opts+=("sort_keys(..)")
        fi
    else
        echo "No parser specified" && exit 1
    fi

    if std::bool::is_true "${argc_copy}"; then
        pbcopy < <(${cmd} "${opts[@]}" . <<<"${content}") && echo "Content copied to the clipboard"
    else
        ${cmd} "${opts[@]}" . <<<"${content}"
    fi
}

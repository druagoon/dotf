/\$\{version\}/ {
    gsub(/\$\{version\}/, version, $0)
}
/^include ".*"/ {
    printf "#%s\n", $0

    file = $2
    gsub(/"/, "", file)
    sub(/~/, ENVIRON["HOME"], file)

    if (system("test -e \"" file "\"") != 0) {
        print "File does not exist: " file >"/dev/stderr"
        exit 1
    }

    while ((getline line < file) > 0)
        print line
    close(file)
    next
}
{ print $0 }

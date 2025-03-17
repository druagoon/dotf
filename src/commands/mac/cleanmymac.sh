# @cmd Clean My Mac
#
# Examples:
#   dotf mac cleanmymac --disable-health-monitor
#   dotf mac cleanmymac --disable-health-monitor --list-files
#
# @flag      --disable-health-monitor       Disable health monitor
# @flag      --list-files                   List files
mac::cleanmymac() {
    local -a bins=(
        "/Applications/CleanMyMac X.app/Contents/Library/LoginItems/CleanMyMac X HealthMonitor.app/Contents/MacOS/CleanMyMac X HealthMonitor"
        "/Applications/CleanMyMac-X.app/Contents/Library/LoginItems/CleanMyMac X HealthMonitor.app/Contents/MacOS/CleanMyMac X HealthMonitor"
    )
    local backup
    for item in "${bins[@]}"; do
        if [[ -f "${item}" ]]; then
            if std::bool::is_true "${argc_disable_health_monitor:-}"; then
                std::tips::info "Disabling health monitor"
                chmod -vv 0444 "${item}" && echo "Ok"
            else
                std::tips::info "Found health monitor in $(std::color::cyan "${item}"), but no action specified"
            fi
            if std::bool::is_true "${argc_list_files:-}"; then
                local dir="$(dirname "${item}")"
                std::tips::info "Listing files in $(std::color::cyan "${dir}")"
                ls -lhA "${dir}"
            fi
        fi
    done
}

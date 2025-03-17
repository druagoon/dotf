# @cmd Beyond Compare
#
# Examples:
#   dotf mac beyond-compare --reset-trial
#
# @flag      --reset-trial          Reset trial
mac::beyond-compare() {
    #     local app_dir="/Applications/Beyond Compare.app/Contents/MacOS"
    #     cd "$app_dir" || exit 1
    #     sudo mv -v BCompare BCompare.bak
    #     cat >>BCompare <<EOF
    # #!/usr/bin/env bash
    # rm "\$HOME/Library/Application Support/Beyond Compare 5/registry.dat"
    # "\`dirname "\$0"\`"/BCompare.bak \$@
    # EOF
    #     chmod -vv +x BCompare

    if std::bool::is_true "${argc_reset_trial:-}"; then
        local registry_dat="${HOME}/Library/Application Support/Beyond Compare 5/registry.dat"
        if [[ -f "${registry_dat}" ]]; then
            std::tips::info "Resetting trial for Beyond Compare"
            rm -f "${registry_dat}" && echo "Ok"
        fi
    fi
}

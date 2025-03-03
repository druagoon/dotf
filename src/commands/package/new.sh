# @cmd Create a new dotfiles package
# @flag      --no-omz-plugin-prefix             Do not use the default oh-my-zsh plugin prefix
# @flag      --no-omz-plugins                   Do not create oh-my-zsh plugins directory
# @flag      --no-omz-functions                 Do not create oh-my-zsh functions directory
# @flag      --no-omz-completions               Do not create oh-my-zsh completions directory
# @arg name!                                    Name of the package
# @arg plugin_names* <PLUGIN_NAME>              Name of the plugins
package::new() {
    local name="${argc_name}"
    local pkg_dir="$(dotf::pkg::dir::get "${name}")"
    local pkg_omz_custom_dir="${pkg_dir}/.oh-my-zsh/custom"
    std::path::dir::ensure "${pkg_omz_custom_dir}"

    if std::bool::is_false "${argc_no_omz_completions:-}"; then
        std::path::dir::ensure "${pkg_omz_custom_dir}/completions"
    fi
    if std::bool::is_false "${argc_no_omz_functions:-}"; then
        std::path::dir::ensure "${pkg_omz_custom_dir}/functions"
    fi
    if std::bool::is_false "${argc_no_omz_plugins:-}"; then
        local -a pkg_omz_plugin_names=("${argc_plugin_names[@]:-"${name}"}")
        if std::bool::is_false "${argc_no_omz_plugin_prefix:-}"; then
            pkg_omz_plugin_names=("${pkg_omz_plugin_names[@]/#/${DF_OMZ_PLUGIN_PREFIX}}")
        fi
        local pkg_omz_plugin_dir pkg_omz_plugin_file pkg_omz_plugin_readme
        for plg_name in "${pkg_omz_plugin_names[@]}"; do
            pkg_omz_plugin_dir="${pkg_omz_custom_dir}/plugins/${plg_name}"
            std::path::dir::ensure "${pkg_omz_plugin_dir}/bin"

            pkg_omz_plugin_file="${pkg_omz_plugin_dir}/${plg_name}.plugin.zsh"
            std::path::file::ensure "${pkg_omz_plugin_file}"

            pkg_omz_plugin_readme="${pkg_omz_plugin_dir}/README.md"
            if [[ ! -f "${pkg_omz_plugin_readme}" ]]; then
                printf "# ${plg_name} plugin\n" >"${pkg_omz_plugin_readme}"
            fi
        done
    fi
}

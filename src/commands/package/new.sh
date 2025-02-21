# @cmd Create a new dotfiles package
# @arg name!
# @option    --omz-plugin-name <NAME>       Name of the oh-my-zsh plugin
# @flag    --no-omz-plugins                 Do not create oh-my-zsh plugins directory
# @flag    --no-omz-functions               Do not create oh-my-zsh functions directory
# @flag    --no-omz-completions             Do not create oh-my-zsh completions directory
package::new() {
    local name="${argc_name}"
    local pkg_dir="$(dotf::pkg::dir::get "${name}")"
    local pkg_omz_custom_dir="${pkg_dir}/.oh-my-zsh/custom"
    std::path::dir::ensure "${pkg_omz_custom_dir}"

    if std::bool::is_false "${argc_no_omz_completions}"; then
        std::path::dir::ensure "${pkg_omz_custom_dir}/completions"
    fi
    if std::bool::is_false "${argc_no_omz_functions}"; then
        std::path::dir::ensure "${pkg_omz_custom_dir}/functions"
    fi
    if std::bool::is_false "${argc_no_omz_plugins}"; then
        local pkg_omz_plugin_name="${argc_omz_plugin_name:-"${DOTF_PLUGIN_PREFIX}-${name}"}"
        local pkg_omz_plugin_dir="${pkg_omz_custom_dir}/plugins/${pkg_omz_plugin_name}"
        std::path::dir::ensure "${pkg_omz_plugin_dir}/bin"

        local pkg_omz_plugin_file="${pkg_omz_plugin_dir}/${pkg_omz_plugin_name}.plugin.zsh"
        std::path::file::ensure "${pkg_omz_plugin_file}"

        local pkg_omz_plugin_readme="${pkg_omz_plugin_dir}/README.md"
        if [[ ! -f "${pkg_omz_plugin_readme}" ]]; then
            printf "# ${pkg_omz_plugin_name} plugin\n" >"${pkg_omz_plugin_readme}"
        fi
    fi
}

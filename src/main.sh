#!/usr/bin/env bash

# @describe `dotf` is a lightweight and flexible CLI tool written in Bash for managing dotfiles efficiently.
#
#      _       _    __
#   __| | ___ | |_ / _|
#  / _` |/ _ \| __| |_
# | (_| | (_) | |_|  _|
#  \__,_|\___/ \__|_|
#
# @meta version ${version}
# @meta require-tools sed
# @meta inherit-flag-options
# @flag -D --debug Enable debug mode

set -e

include "lib/std/bool.sh"
include "lib/std/string.sh"
include "lib/std/os.sh"
include "lib/std/colors.sh"
include "lib/std/message.sh"
include "lib/std/path.sh"

include "lib/local/consts.sh"
include "lib/local/path.sh"

# Commands
include "commands/brewfile/cli.sh"
include "commands/brewfile/generate.sh"

include "commands/clipboard/cli.sh"
include "commands/clipboard/parse.sh"

include "commands/completion/cli.sh"
include "commands/completion/go.sh"
include "commands/completion/rust.sh"

include "commands/download.sh"

include "commands/gitignore/cli.sh"
include "commands/gitignore/generate.sh"

include "commands/link.sh"

include "commands/layout/cli.sh"
include "commands/layout/export.sh"
include "commands/layout/import.sh"

include "commands/package/cli.sh"
include "commands/package/new.sh"

include "hooks.sh"

# See more details at https://github.com/sigoden/argc
eval "$(argc --argc-eval "$0" "$@")"

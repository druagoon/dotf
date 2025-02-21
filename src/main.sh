#!/usr/bin/env bash

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

include "commands/completion/cli.sh"
include "commands/completion/go.sh"
include "commands/completion/icli.sh"
include "commands/completion/rust.sh"

include "commands/gitignore/cli.sh"
include "commands/gitignore/generate.sh"

include "commands/link.sh"

include "commands/layout/cli.sh"
include "commands/layout/export.sh"
include "commands/layout/sync.sh"

include "commands/package/cli.sh"
include "commands/package/new.sh"

#!/bin/bash
# Run the busted test suite inside headless Neovim
# Usage: bash tests/run.sh [busted args...]
#   e.g. bash tests/run.sh --filter="options"

set -euo pipefail
cd "$(dirname "$0")/.."

# Add luarocks paths so busted is found
eval "$(luarocks --lua-version 5.1 path --bin 2>/dev/null)" || true

nvim --headless -u tests/minimal_init.lua \
  -c "lua local ok, code = pcall(function() require('busted.runner')({ standalone = false }) end); vim.cmd('cquit ' .. (ok and 0 or 1))" \
  -- tests/ "$@"

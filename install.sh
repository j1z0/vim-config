#!/usr/bin/env bash
# Symlink this repo in as your neovim config. Idempotent.
set -uo pipefail
SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DST="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"

if [[ -e "$DST" && ! -L "$DST" ]]; then
  BACKUP="$DST.backup.$(date +%Y%m%d-%H%M%S)"
  mv "$DST" "$BACKUP"
  echo "moved your existing config to $BACKUP"
fi

mkdir -p "$(dirname "$DST")"
ln -snf "$SRC" "$DST"
echo "linked $DST -> $SRC"

command -v nvim >/dev/null || { echo "neovim isn't installed: brew install neovim" >&2; exit 1; }
echo "installing plugins..."
nvim --headless "+Lazy! sync" +qa
echo
echo "Treesitter parsers compile C. If that fails on macOS with a libSystem.tbd"
echo "linker error, the Command Line Tools compiler is older than its default"
echo "SDK; export SDKROOT to the newest SDK it accepts, e.g."
echo '  export SDKROOT=/Library/Developer/CommandLineTools/SDKs/MacOSX26.5.sdk'

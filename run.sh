#!/usr/bin/env bash
# Launch Riff as a standalone app window (no tabs, no address bar).
set -euo pipefail

exec brave \
  --app=file:///home/nikita/Projects/riff/index.html \
  --class=riff \
  --user-data-dir="${XDG_DATA_HOME:-$HOME/.local/share}/riff/profile" \
  --window-size=560,860 \
  --ozone-platform=x11 \
  --no-first-run \
  --no-default-browser-check \
  "$@"

#!/bin/sh
# Installs the personal setup that lives outside the repo: FRYHiTE skin + `aizen` command.
# Safe to re-run. Run from anywhere: sh custom/install.sh
set -e
here=$(cd "$(dirname "$0")" && pwd)
home="${HERMES_HOME:-$HOME/.hermes}"
bin="${BIN_DIR:-$HOME/.local/bin}"
mkdir -p "$home/skins" "$bin"
cp "$here/skins/fryhite.yaml" "$home/skins/"
cp "$here/UPDATE.md" "$home/UPDATE.md"
# the wrapper calls hermes by absolute path, so point it at this machine's bin dir
sed "s#/home/aswin/.local/bin#$bin#" "$here/bin/aizen" > "$bin/aizen"
chmod +x "$bin/aizen"
hermes config set display.skin fryhite
echo "done: skin fryhite active, 'aizen' installed in $bin (make sure it is on PATH)"

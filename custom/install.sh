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
# rename the desktop launcher's hover text (file only exists after `hermes desktop` installs it)
desk="${DESKTOP_FILE:-$HOME/.local/share/applications/com.nousresearch.hermes.desktop}"
[ -f "$desk" ] && sed -i 's/^Name=Hermes$/Name=Aizen/; s/^GenericName=Hermes Desktop/GenericName=Aizen Desktop/; s/^Comment=Launch Hermes Desktop/Comment=Launch Aizen Desktop/' "$desk"
echo "done: skin fryhite active, 'aizen' installed in $bin (make sure it is on PATH)"

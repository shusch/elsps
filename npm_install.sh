#!/bin/sh

# Usage: npm_install.sh [npm_package] [command_name]

set -euo pipefail

if [ "$#" -ne 2 ]; then
  echo "Invalid argument" >&2
  exit 1
fi

server_dir="elsps/servers/${2}"

if [ -n "${XDG_DATA_HOME-}" ]; then
  server_path="${XDG_DATA_HOME}/${server_dir}"
else
  server_path="${HOME}/.local/share/${server_dir}"
fi

if [ ! -d "$server_path" ]; then
  echo "mkdir: $(mkdir -pv "$server_path")"
fi

if cd "$server_path"; then
  if [ ! -f "package.json" ]; then
    npm init -y
  fi
  npm install "$1"
else
  echo "cd Failed" >&2
  exit 1
fi

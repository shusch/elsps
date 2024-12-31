#!/bin/sh

# Usage: pylsp_install.sh

set -euo pipefail

server_dir="elsps/servers/python-lsp-server"

if [ -n "${XDG_DATA_HOME-}" ]; then
  server_path="${XDG_DATA_HOME}/${server_dir}"
else
  server_path="${HOME}/.local/share/${server_dir}"
fi

if [ ! -d "$server_path" ]; then
  echo "mkdir: $(mkdir -pv "$server_path")"
fi

if cd "$server_path"; then
  python3 -m venv venv
  ./venv/bin/pip install "python-lsp-server[all]"
else
  echo "cd Failed" >&2
  exit 1
fi

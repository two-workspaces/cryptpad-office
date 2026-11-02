#!/bin/bash
# Railway entrypoint for CryptPad. The first admin claims the instance with a generated
# token, so nobody can take it by opening the URL first.
set -euo pipefail

: "${CRYPTPAD_ORIGIN:?CRYPTPAD_ORIGIN is not set}"
: "${CRYPTPAD_SANDBOX_ORIGIN:?CRYPTPAD_SANDBOX_ORIGIN is not set}"

# Railway mounts the volume as root; CryptPad runs as its own user.
mkdir -p /data/datastore /data/block /data/blob /data/data/decrees
chown -R cryptpad:cryptpad /data

as_cryptpad() { setpriv --reuid=4001 --regid=4001 --clear-groups env HOME=/cryptpad "$@"; }

decrees=/data/data/decrees/decree.ndjson
if ! grep -qs ADD_INSTALL_TOKEN "$decrees"; then
  token="${CRYPTPAD_INSTALL_TOKEN:?CRYPTPAD_INSTALL_TOKEN is not set}"
  [ "${#token}" = 64 ] || { echo "railway: CRYPTPAD_INSTALL_TOKEN must be 64 characters"; exit 1; }
  echo "[\"ADD_INSTALL_TOKEN\",[\"$token\"],\"\",$(date +%s)000]" >> "$decrees"
  chown cryptpad:cryptpad "$decrees"
fi

cd /cryptpad
as_cryptpad npm run build >/dev/null
exec setpriv --reuid=4001 --regid=4001 --clear-groups env HOME=/cryptpad node server.js

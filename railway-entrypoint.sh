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

# Seeded here rather than left to the server: when it writes the bearer secret itself on a
# fresh volume, its startup never finishes that boot, so the block store's placeholder and
# the install link don't appear until a restart.
decrees=/data/data/decrees/decree.ndjson
if [ ! -s "$decrees" ]; then
  token="${CRYPTPAD_INSTALL_TOKEN:?CRYPTPAD_INSTALL_TOKEN is not set}"
  [ "${#token}" = 64 ] || { echo "railway: CRYPTPAD_INSTALL_TOKEN must be 64 characters"; exit 1; }
  now="$(date +%s)000"
  {
    echo "[\"ADD_INSTALL_TOKEN\",[\"$token\"],\"\",$now]"
    echo "[\"SET_BEARER_SECRET\",[\"$(head -c 32 /dev/urandom | base64)\"],\"INTERNAL\",$now]"
  } > "$decrees"
  chown cryptpad:cryptpad "$decrees"
fi

cd /cryptpad
as_cryptpad npm run build >/dev/null
exec setpriv --reuid=4001 --regid=4001 --clear-groups env HOME=/cryptpad node server.js

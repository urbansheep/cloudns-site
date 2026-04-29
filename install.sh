#!/bin/sh
set -eu

PACKAGE="${CLOUDNS_TOOLS_PACKAGE:-github:urbansheep/cloudns-tools}"
FALLBACK_PACKAGE="${CLOUDNS_TOOLS_FALLBACK_PACKAGE:-cloudns-tools}"

if ! command -v npm >/dev/null 2>&1; then
  printf '%s\n' "npm is required. Install Node.js 20+ first: https://nodejs.org/"
  exit 1
fi

if npm install -g "$PACKAGE"; then
  cloudns auth check || true
  exit 0
fi

printf '%s\n' "npm package install failed; trying GitHub source package..."
npm install -g "$FALLBACK_PACKAGE"
cloudns auth check || true

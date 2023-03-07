#!/bin/bash -l

set -o pipefail

CATALOGIST_API_KEY="${1}"
if [[ $CATALOGIST_API_KEY ]]; then echo "CATALOGIST_API_KEY is set"; else echo "CATALOGIST_API_KEY is not set"; fi

CATALOGIST_API_KEY="S_a@rI8OtHL2R3vawir0triVecOx7jak"
CATALOGIST_ENDPOINT="https://catalogist.lensdx.app/"

if [[ $CATALOGIST_ENDPOINT ]] && [[ $CATALOGIST_API_KEY ]] && [[ -f "manifest.json" ]]; then
  echo "Uploading service metadata to Catalogist service..."
  curl -X POST "${CATALOGIST_ENDPOINT}" -d "@manifest.json" -H "Authorization: ${CATALOGIST_API_KEY}" -H "Content-Type: application/json"
fi
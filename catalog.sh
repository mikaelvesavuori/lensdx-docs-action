#!/bin/bash -l

set -o pipefail

API_KEY="${1}"
if [[ $API_KEY ]]; then echo "API key is set"; else echo "API key is not set"; fi

REPO_NAME="$GITHUB_REPOSITORY"
ENDPOINT="https://catalogist.lensdx.app"

if [[ $API_KEY ]] && [[ $ENDPOINT ]] && [[ -f "manifest.json" ]]; then
  echo "Uploading service metadata to Catalogist service..."
  curl -X POST "$ENDPOINT/record" -d "@manifest.json" -H "Authorization: $API_KEY" -H "Content-Type: application/json"
fi
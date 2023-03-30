#!/bin/bash -l

set -o pipefail

API_KEY="${1}"
if [ -z "$API_KEY" ]; then echo "LensDX error: API key is not set! Exiting..." && exit 1; fi

REPO_NAME="${2}"
if [ -z "$REPO_NAME" ]; then echo "LensDX error: Repository name is not set! Exiting..." && exit 1; fi

ENDPOINT="https://catalogist.lensdx.app"

if [[ $API_KEY ]] && [[ $ENDPOINT ]] && [[ -f "manifest.json" ]]; then
  echo "Uploading service metadata to LensDX..."
  curl -X POST "$ENDPOINT/record" -d "@manifest.json" -H "Authorization: $API_KEY" -H "Content-Type: application/json"
fi
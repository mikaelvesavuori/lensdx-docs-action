#!/bin/bash -l

set -o pipefail

API_KEY="${1}"
if [[ $API_KEY ]]; then echo "API_KEY is set"; else echo "API_KEY is not set"; fi

PRODUCT_NAME="${2}"
echo "Product name is $PRODUCT_NAME"

API_KEY="S_a@rI8OtHL2R3vawir0triVecOx7jak"
ENDPOINT="https://catalogist.lensdx.app/"

if [[ $ENDPOINT ]] && [[ $API_KEY ]] && [[ -f "manifest.json" ]]; then
  echo "Uploading service metadata to Catalogist service..."
  curl -X POST "${ENDPOINT}" -d "@manifest.json" -H "Authorization: ${API_KEY}" -H "Content-Type: application/json"
fi
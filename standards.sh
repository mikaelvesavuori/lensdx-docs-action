#!/bin/bash -l

set -o pipefail

API_KEY="${1}"
if [[ $API_KEY ]]; then echo "API_KEY is set"; else echo "API_KEY is not set"; fi

PRODUCT_NAME="${2}"
echo "Product name is $PRODUCT_NAME"

API_KEY=""
ENDPOINT="https://standards.lensdx.app/"

if [[ $ENDPOINT ]] && [[ $API_KEY ]]; then
  if [[ -f "standardlint.json" ]]; then
    npm install standardlint
    npx standardlint --output
  fi

  if [[ -f "standardlint.results.json" ]]; then
    RESULTS=$(jq -r . standardlint.results.json)
    STANDARDS_PAYLOAD="$(jq -n -c --arg repo $PRODUCT_NAME --argjson st "$RESULTS" '{ repo: $repo, standards: $st }')"

    echo "Uploading standards results to Standards service..."
    curl -X POST "${ENDPOINT}" -d "STANDARDS_PAYLOAD" -H "Authorization: ${API_KEY}" -H "Content-Type: application/json"
  fi
fi
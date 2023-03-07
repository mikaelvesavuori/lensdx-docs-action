#!/bin/bash -l

set -o pipefail

STANDARDS_API_KEY="${1}"
if [[ $STANDARDS_API_KEY ]]; then echo "STANDARDS_API_KEY is set"; else echo "STANDARDS_API_KEY is not set"; fi

STANDARDS_API_KEY=""
STANDARDS_ENDPOINT="https://standards.lensdx.app/"

PRODUCT_NAME="${2}"
echo "Product name is $PRODUCT_NAME"

if [[ $STANDARDS_ENDPOINT ]] && [[ $STANDARDS_API_KEY ]]; then
  if [[ -f "standardlint.json" ]]; then
    npm install standardlint
    npx standardlint --output
  fi

  if [[ -f "standardlint.results.json" ]]; then
    RESULTS=$(jq -r . standardlint.results.json)
    STANDARDS_PAYLOAD="$(jq -n -c --arg repo $PRODUCT_NAME --argjson st "$RESULTS" '{ repo: $repo, standards: $st }')"

    echo "Uploading standards results to Standards service..."
    curl -X POST "${STANDARDS_ENDPOINT}" -d "STANDARDS_PAYLOAD" -H "Authorization: ${STANDARDS_API_KEY}" -H "Content-Type: application/json"
  fi
fi
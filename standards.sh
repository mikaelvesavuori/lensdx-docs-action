#!/bin/bash -l

set -o pipefail

REPO_NAME="$GITHUB_REPOSITORY"

ENDPOINT="https://standards.lensdx.app"

if [[ $REPO_NAME ]] && [[ $ENDPOINT ]]; then
  if [[ -f "standardlint.json" ]]; then
    npm install standardlint
    npx standardlint --output
  fi

  if [[ -f "standardlint.results.json" ]]; then
    RESULTS=$(jq -r . standardlint.results.json)
    jq -n -c --arg repo $REPO_NAME --argjson standards "$RESULTS" '{ repo: $repo, standards: $standards }' > standards.json

    echo "Uploading standards results to Standards service..."
    curl -X PUT "$ENDPOINT/standards?$REPO_NAME" -d "@standards.json" -H "Authorization: $API_KEY" -H "Content-Type: application/json"
  fi
fi
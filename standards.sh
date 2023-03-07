#!/bin/bash -l

set -o pipefail

#API_KEY="${1}"
#if [[ $API_KEY ]]; then echo "API_KEY is set"; else echo "API_KEY is not set"; fi

#REPO_NAME="${2}"
#echo "Product name is $REPO_NAME"
#echo "Repo name is $GITHUB_REPOSITORY"

REPO_NAME="$GITHUB_REPOSITORY"
ENDPOINT="https://standards.lensdx.app/"

if [[ $REPO_NAME ]] && [[ $ENDPOINT ]]; then
  if [[ -f "standardlint.json" ]]; then
    npm install standardlint
    npx standardlint --output
  fi

  if [[ -f "standardlint.results.json" ]]; then
    RESULTS=$(jq -r . standardlint.results.json)
    jq -n -c --arg repo $REPO_NAME --argjson st "$RESULTS" '{ repo: $repo, standards: $st }' > standards.json

    echo "Uploading standards results to Standards service..."
    curl -X POST "${ENDPOINT}" -d "@standards.json" -H "Authorization: ${API_KEY}" -H "Content-Type: application/json"
  fi
fi
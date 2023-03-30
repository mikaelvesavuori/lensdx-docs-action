#!/bin/bash -l

set -o pipefail

#REPO_NAME="${1}"
#echo "Product name is $REPO_NAME"
#echo "Repo name is $GITHUB_REPOSITORY"

REPO_NAME="$GITHUB_REPOSITORY"
ENDPOINT="https://standards.lensdx.app"

REPO="$GITHUB_REPOSITORY"
echo "Internal value for GH repo is $REPO"

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
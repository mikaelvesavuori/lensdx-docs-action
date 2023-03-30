# LensDX Docs Action

This Action allows you to push a service catalog record and standards (checks) results to LensDX.

## Setup and usage

You need to set a required secret for an API key, then you are greenlit to just start using the action!

### Updating the service catalog

The service catalog step requires you to have a `manifest.json` file on disk. Please see the [Catalogist documentation](https://github.com/mikaelvesavuori/catalogist#manifest) for more details.

### Running the standards check

For the standards check to run and results to be sent, the only thing you need to run this action is a `standardlint.json` configuration file in your root directory. Please see the [StandardLint documentation](https://github.com/mikaelvesavuori/standardlint#configuration) for more details.

### Remember...

Always ensure you have secure settings regarding what actions you allow.

## Required input arguments

### `api-key`

LensDX API key.

## Environment variables the action uses

This action will use `${GITHUB_REPOSITORY}` to grab the repository name.

## Example of how to use this action in a workflow

```yml
on: [push]

jobs:
  lensdx-docs:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      # Do your things here: build, test, deploy...

      - name: Run LensDX Docs action
        uses: lensdx/lensdx-docs-action@v0
        with:
          api-key: ${{ secrets.LENSDX_DOCS_API_KEY }}
```

# LensDX Docs Action

This Action allows you to push a service catalog entry and standards (checks) results to LensDX.

## Setup and usage

### Inputs

There are two optional inputs you can provide: `api-key` and `product-name`.

The `api-key` will resort to a working alpha key, so avoid setting this while in alpha.

The `product-name` is taken from the repository and does not need to be explicitly set.

### Updating the service catalog

The service catalog step requires you to have a `manifest.json` file on disk. Please see the [Catalogist documentation](https://github.com/mikaelvesavuori/catalogist#manifest) for more details.

### Running the standards check

For the standards check to run and results to be sent, the only thing you need to run this action is a `standardlint.json` configuration file in your root directory. Please see the [StandardLint documentation](https://github.com/mikaelvesavuori/standardlint#configuration) for more details.

## Example of how to use this action in a workflow

```yml
on: [push]

jobs:
  main:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Push to LensDX
        uses: lensdx/lensdx-docs-action@v0
        # Optional
        with:
          api-key: your-key-here
          product-name: my-repo
```

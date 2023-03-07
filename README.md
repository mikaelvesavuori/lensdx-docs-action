# LensDX Docs Action

This Action allows you to push a service catalog entry and standards (checks) results to LensDX.

## Setup and usage

There are two optional inputs you can provide: `api-key` and `product-name`.

The `api-key` will resort to a working alpha key, so avoid setting this while in alpha.

The `product-name` is taken from the repository and does not need to be explicitly set.

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
        with:
          api-key: your-key-here
          product-name: my-repo
```

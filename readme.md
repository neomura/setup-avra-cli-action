# neomura/setup-avra-cli-action

GitHub Action to build and install the AVRA CLI.

## License

While this repository is [MIT licensed](./license.md), it includes a Git submodule of the [AVRA repository](https://github.com/Ro5bert/avra), which uses the GPL-2.0 license.

You should make your own checks to ensure that your usage of this GitHub action is valid within its license agreement.

## Supported virtual environments

Supported virtual environments are listed in the [test workflow](./.github/workflows/test.yaml).

## Usage

```yaml
on: [push]

jobs:
  example:
    runs-on: ubuntu-latest
    steps:

    # load your repository.
    - uses: actions/checkout@v2

    # install this github action.
    - uses: neomura/setup-avra-cli-action@v1.0.1

    # avra is now available on the path.
    - run: avra --help
```

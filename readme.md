# neomura > setup avra cli action

github action to build and install avra cli

## license

while this repository is [mit licensed](./license.md), it includes a git
submodule of the [avra repository](https://github.com/Ro5bert/avra), which uses
the gpl-2.0 license.

you should make your own checks to ensure that your usage of this github action
is valid within its license agreement.

## supported virtual environments

supported virtual environments are listed in the
[test workflow](./.github/workflows/test.yaml).

## usage

```yaml
on: [push]

jobs:
  example:
    runs-on: ubuntu-latest
    steps:

    # load your repository.
    - uses: actions/checkout@v2

    # install this github action.
    - uses: neomura/setup-avra-cli-action@v1.0.0

    # avra is now available on the path.
    - run: avra --help
```

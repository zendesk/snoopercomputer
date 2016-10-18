# Snoopercomputer
A CI-friendly automated security testing tool

## Installation
Assumes Ruby and Bundler already installed.

Clone repo and install:
```shell
$ bundle install
```

## Running tests
To run example `targets` file:
- Rename `spec/fixtures/targets/targets.json.example` to `targets.json`
- Run with `$ bundle exec rake targets=targets`

# Contributing

Testing Locally:

```shell
asdf plugin test <plugin-name> <plugin-url> [--asdf-tool-version <version>] [--asdf-plugin-gitref <git-ref>] [test-command*]

asdf plugin test clickhouse https://github.com/Coolomina/asdf-clickhouse.git "clickhouse server --help"
```

Tests are automatically run in GitHub Actions on push and PR.

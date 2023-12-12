<div align="center">

# asdf-clickhouse [![Build](https://github.com/tinybirdco/asdf-clickhouse/actions/workflows/build.yml/badge.svg)](https://github.com/tinybirdco/asdf-clickhouse/actions/workflows/build.yml) [![Lint](https://github.com/tinybirdco/asdf-clickhouse/actions/workflows/lint.yml/badge.svg)](https://github.com/tinybirdco/asdf-clickhouse/actions/workflows/lint.yml)

[ClickHouse](https://clickhouse.com/docs) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `bash`, `curl`, `tar`, and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).

# Install

Plugin:

```shell
asdf plugin add clickhouse https://github.com/tinybirdco/asdf-clickhouse.git
```

clickhouse:

```shell
# Show all installable versions
asdf list-all clickhouse

# Install specific version
asdf install clickhouse latest

# Set a version globally (on your ~/.tool-versions file)
asdf global clickhouse latest

# Set a local version (for your current directory)
asdf local clickhouse latest

# Now clickhouse commands are available
clickhouse server --help
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/tinybirdco/asdf-clickhouse/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Tinybird Co.](https://github.com/tinybirdco)

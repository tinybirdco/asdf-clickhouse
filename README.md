<div align="center">

# asdf-clickhouse [![Build](https://github.com/Coolomina/asdf-clickhouse/actions/workflows/build.yml/badge.svg)](https://github.com/Coolomina/asdf-clickhouse/actions/workflows/build.yml) [![Lint](https://github.com/Coolomina/asdf-clickhouse/actions/workflows/lint.yml/badge.svg)](https://github.com/Coolomina/asdf-clickhouse/actions/workflows/lint.yml)

[clickhouse](https://clickhouse.com/docs) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

**TODO: adapt this section**

- `bash`, `curl`, `tar`, and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

# Install

Plugin:

```shell
asdf plugin add clickhouse
# or
asdf plugin add clickhouse https://github.com/Coolomina/asdf-clickhouse.git
```

clickhouse:

```shell
# Show all installable versions
asdf list-all clickhouse

# Install specific version
asdf install clickhouse latest

# Set a version globally (on your ~/.tool-versions file)
asdf global clickhouse latest

# Now clickhouse commands are available
clickhouse server --help
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/Coolomina/asdf-clickhouse/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Alejandro Colomina](https://github.com/Coolomina/)

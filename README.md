<div align="center">

# asdf-djinni ![Build](https://github.com/cross-language-cpp/asdf-djinni/workflows/Build/badge.svg?event=push&branch=main) ![Lint](https://github.com/cross-language-cpp/asdf-djinni/workflows/Lint/badge.svg?event=push&branch=main)

[djinni](https://djinni.xlcpp.dev) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Why?](#why)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

Java, either on the system, or better, via some asdf-java

# Install

Plugin:

```shell
asdf plugin djinni
```


djinni:

```shell
# Show all installable versions
asdf list-all djinni

# Install specific version
asdf install djinni latest

# Set a version globally (on your ~/.tool-versions file)
asdf global djinni latest

# Now djinni commands are available
djinni --help
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Why ?

Because this is the most convenient way to install [djinni](https://djinni.xlcpp.dev)

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/cross-language-cpp/asdf-djinni/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [xlcpp](https://github.com/cross-language-cpp/)

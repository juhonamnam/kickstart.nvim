## Installation Guide

- install `neovim` from source

```sh
# Install prerequisites
sudo apt-get install ninja-build gettext cmake unzip curl

# Clone Source
git clone https://github.com/neovim/neovim

# Stable version
git checkout stable

# Install
make CMAKE_BUILD_TYPE=Release
sudo make install
```

- Install [ripgrep](https://github.com/BurntSushi/ripgrep#installation) for Search by Grep

```sh
sudo apt install ripgrep
```

- Install `xclip` to use system clipboard copy & paste

```sh
sudo apt install xclip
```


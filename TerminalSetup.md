# TERMINAL SETUP (With ZSH)
## We need to setup the following plugins.
| # | Plugin |
| ------ | ------ |
| 1 | [ZSH](https://github.com/abbackend/setup/blob/main/TerminalSetup.md#zsh) |

## ZSH
``` sh
# Install
sudo apt-get install zsh
```

``` sh
# Unistall
sudo apt-get remove --purge zsh
```

> **_NOTE:_** Then we have to do some manual configuration to run the zsh on your system.

1. Copy the content of [zshrc](https://github.com/abbackend/setup/blob/main/zshrc) file and then paste this into the `/.zshrc` file.
2. Download the [oh-my-zsh](https://github.com/abbackend/setup/blob/main/oh-my-zsh.zip) zip file and extract it, you can found `.oh-my-zsh` folder under the `oh-my-zsh` directory.
3. Copy `.oh-my-zsh` folder and paste this into the `~/` directory.
4. Your zsh setup is completed.

> **_NOTE:_** If you want to make zsh as default terminal then you have to run this command.
``` sh
sudo chsh -s $(which zsh) && reboot
```

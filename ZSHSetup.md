<img src="https://github.com/abbackend/portfolio/blob/master/channels4_banner.jpg" width="100%"/>

# ZSH Setup

This guide will walk you through setting up zsh on your Linux system with straightforward steps, without needing to search on Google.
## Installation
Follow these steps after cloning the repository.

### Step 1
Change into the directory of the cloned repository.
```bash
  cd ./zsh-setup
```

### Step 2
Grant executable permissions to the main script.
```bash
  sudo chmod +x ./zshsetup.sh
```

### Step 3
Execute the script.
```bash
  ./zshsetup.sh
```

### Step 4
Restart your system with the following command.
```bash
  reboot
```
## Appendix
Additional customizations you can make to your configuration.

### Change the Zsh Theme
To change the theme, use the following command with the `nano` text editor:
```bash
  nano /.zshrc
```

This will open the file in edit mode. Modify the `ZSH_THEME` variable to select your desired theme. You can find all available themes [here](https://github.com/ohmyzsh/ohmyzsh/wiki/Themes).

### Modify Plugins
To customize the plugins, use the following command with the `nano` text editor
```bash
 nano /.zshrc
```

In the file that opens, update the `plugins` variable to include your preferred plugins. Here is a recommended configuration
```bash
plugins=(
        git
        zsh-autosuggestions
        zsh-history-substring-search
        zsh-syntax-highlighting
)
```
You can explore available plugins [here](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins).
## Author

- [@abbackend](https://www.github.com/abbackend)

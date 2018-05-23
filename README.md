# Dotfiles

### Requirement

- **OS X** higher than or equal to _10.10 Yosemite_
- [Homebrew](http://brew.sh/)
- [iTerm2](http://iterm2.com/)

### Installation

1. Clone this repository

  ```bash
  cd ~
  git clone git@github.com:heejongahn/dotfiles.git
  ```

1. Install [zsh][fish] and make it a default shell.
  ```bash
  # OS X
  brew install zsh

  # Ubuntu (using PPA)
  sudo apt-add-repository ppa:fish-shell/release-2
  sudo apt-get update
  sudo apt-get install zsh

  chsh -s /usr/local/bin/zsh
  ```

1. Let the script to do the rest for you

  ```fish
  source install.sh
  ```

### In details

1. Make symlinks of dotfiles to home folder

  ```bash
  cd ~
  mkdir -p .config/nvim  ; ln -sf ~/dotfiles/.vimrc      .config/nvim/init.vim
  mkdir -p .ssh ; chmod 700 .ssh ; ln -sf ~/dotfiles/.ssh/config .ssh

  ln -sf dotfiles/.vimrc
  ln -sf dotfiles/.gitconfig
  ln -sf dotfiles/.gitignore
  ln -sf dotfiles/.gemrc
  ```

1. Install [vim-plug][vim-plug], plugins and Python provider

  ```bash
  pip install --user --upgrade neovim # For MatchTagAlways Plug
  curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  vim +PlugInstall -c cq
  ```
1. (Optional) Set color scheme, weechat, ssh, ...

1. Enjoy Coding!

#### Special Thanks To

- [Hyeon Kim][hyeon]'s dotfiles


[zsh]: http://www.zsh.org/ 
[vim-plug]: https://github.com/junegunn/vim-plug
[hyeon]: https://github.com/simnalamburt

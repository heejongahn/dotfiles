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

2. Install [fish](https://fishshell.com) and [chips](https://github.com/kinoru/chips) (no puns intended)

  ```bash
  # OS X
  brew install

  # Ubuntu (using PPA)
  sudo apt-add-repository ppa:fish-shell/release-2
  sudo apt-get update
  sudo apt-get install fish
  ```

3. Make sure your default shell is fish

  ```bash
  # OS X
  chsh -s /usr/local/bin/fish

  # Ubuntu
  chsh -s /usr/bin/fish
  ```

4. Make symlinks of dotfiles to home folder

  ```bash
  mkdir -p .config/fish  ; ln -sf ~/dotfiles/config.fish .config/fish
  mkdir -p .config/chips ; ln -sf ~/dotfiles/plugin.yaml .config/chips
  mkdir -p .config/nvim  && ln -sf ~/dotfiles/.vimrc      .config/nvim/init.vim
  mkdir -p .ssh ; chmod 700 .ssh ; ln -sf ~/dotfiles/.ssh/config .ssh

  ln -sf dotfiles/.vimrc
  ln -sf dotfiles/.gitconfig
  ln -sf dotfiles/.gitignore
  ln -sf dotfiles/.gemrc
  ```

5. Install [Vim-Plug](https://github.com/junegunn/vim-plug)

  ```bash
  curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  ```

6. type `:PlugInstall` in vim

7. (Optional) Set color scheme, weechat, ssh, ...

8. Enjoy Coding!

#### Special Thanks To

- [Hyeon Kim](https://github.com/simnalamburt)'s dotfiles
- [Jordan Bramble](https://github.com/jbrambleDC)'s bashrc

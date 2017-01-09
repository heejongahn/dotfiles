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

1. Install [fish shell][fish] and make it a default shell.
  ```bash
  # OS X
  brew install fish

  # Ubuntu (using PPA)
  sudo apt-add-repository ppa:fish-shell/release-2
  sudo apt-get update
  sudo apt-get install fish

  chsh -s /usr/local/bin/fish
  ```

1. Let the fish script to do the rest for you

  ```fish
  source install.fish
  ```

### In details

1. Install [The Haskell Tool Stack][stack]
  ```fish
  curl -sSL https://get.haskellstack.org/ | sh
  ```

1. Install the latest version of [chips][chips]

  ```fish
  cd ~
  git clone --depth 1 git@github.com:xtendo-org/chips.git
  cd chips; stack setup; stack install
  ```
1. Make symlinks of dotfiles to home folder

  ```bash
  cd ~
  mkdir -p .config/fish  ; ln -sf ~/dotfiles/config.fish .config/fish
  mkdir -p .config/chips ; ln -sf ~/dotfiles/plugin.yaml .config/chips
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


[fish]: https://fishshell.com
[stack]: http://haskellstack.org/
[chips]: https://github.com/kinoru/chips
[vim-plug]: https://github.com/junegunn/vim-plug
[hyeon]: https://github.com/simnalamburt

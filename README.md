# Dotfiles

### Requirement

- **OS X** higher than or equal to _10.10 Yosemite_
- [Homebrew](http://brew.sh/)
- [iTerm2](http://iterm2.com/)

### Installation

1. Clone this repository

  ```bash
  git clone git@github.com:heejongahn/dotfiles.git
  ```

2. Install [ZSH](http://www.zsh.org/) and [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)

  ```bash
  brew install zsh
  sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  ```

3. Make sure your default shell is ZSH

  ```bash
  chsh -s /bin/zsh
  ```

4. Install [Vim-Plug](https://github.com/junegunn/vim-plug)

  ```bash
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  ```

5. type `:PlugInstall` in vim

6. (Optional) Set color scheme, weechat, ssh, ...

7. Enjoy Coding!

#### Special Thanks To

- [Hyeon Kim](https://github.com/simnalamburt)'s dotfiles
- [Jordan Bramble](https://github.com/jbrambleDC)'s bashrc

#!/usr/local/bin/fish

cd ~

# Install the haskell tool stack
curl -sSL https://get.haskellstack.org/ | sh

# Install the lastest version of chips
cd ~
git clone --depth 1 git@github.com:xtendo-org/chips.git
cd chips; stack setup; stack install

# Make symlinks of dotfiles to home folder
cd ~
mkdir -p .config/fish  ; ln -sf ~/dotfiles/config.fish .config/fish
mkdir -p .config/chips ; ln -sf ~/dotfiles/plugin.yaml .config/chips
mkdir -p .config/nvim  ; ln -sf ~/dotfiles/.vimrc      .config/nvim/init.vim
mkdir -p .ssh ; chmod 700 .ssh ; ln -sf ~/dotfiles/.ssh/config .ssh

ln -sf dotfiles/.vimrc
ln -sf dotfiles/.gitconfig
ln -sf dotfiles/.gitignore

# Install vim-plug, plugins and Python provider
pip install --user --upgrade neovim # For MatchTagAlways Plug
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall -c cq

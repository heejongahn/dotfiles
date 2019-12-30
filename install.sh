# Utlities
brew install zsh neovim node python3
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Make symlinks of dotfiles to home folder
cd ~
mkdir -p .config/nvim  ; ln -sf ~/dotfiles/.vimrc      .config/nvim/init.vim
mkdir -p .ssh ; chmod 700 .ssh ; ln -sf ~/dotfiles/.ssh/config .ssh

# ZSH
curl -o ~/.oh-my-zsh/themes/bullet-train.zsh-theme https://raw.githubusercontent.com/caiogondim/bullet-train-oh-my-zsh-theme/master/bullet-train.zsh-theme
ln -sf dotfiles/.zshrc

# VIM
ln -sf dotfiles/.vimrc
ln -sf dotfiles/.gitconfig
ln -sf dotfiles/.gitignore

# Install vim-plug, plugins and Python provider
pip3 install --user --upgrade neovim # For MatchTagAlways Plug
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall -c cq

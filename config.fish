if type -q nvim; alias vim='nvim'; end # neovim

alias ta='tmux attach'
set PATH $PATH ~/.local/bin node_modules/.bin/ /Applications/Postgres.app/Contents/Versions/latest/bin

# chips
if [ -e ~/.config/chips/build.fish ] ; source ~/.config/chips/build.fish ; end

# pyenv & pyenv-virtualenv
status --is-interactive; and source (pyenv init -|psub)
status --is-interactive; and source (pyenv virtualenv-init -|psub)

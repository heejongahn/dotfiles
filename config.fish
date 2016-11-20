# pyenv
status --is-interactive; and . (pyenv init -|psub)

if type -q nvim; alias vim='nvim'; end # neovim
alias ta='tmux attach'
alias npm='yarn'
set PATH $PATH ~/.local/bin node_modules/.bin/

# chips
if [ -e ~/.config/chips/build.fish ] ; source ~/.config/chips/build.fish ; end

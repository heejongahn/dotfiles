# pyenv
status --is-interactive; and . (pyenv init -|psub)

if type -q nvim; alias vim='nvim'; end # neovim
alias ta='tmux attach'
set PATH $PATH ~/.local/bin

# chips
if [ -e ~/.config/chips/build.fish ] ; source ~/.config/chips/build.fish ; end

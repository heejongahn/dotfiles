# neovim
alias vim='nvim'; alias v='vim +F';

alias ta='tmux attach'
set PATH $PATH ~/.local/bin node_modules/.bin/ /Applications/Postgres.app/Contents/Versions/latest/bin

# chips
if [ -e ~/.config/chips/build.fish ] ; source ~/.config/chips/build.fish ; end

# pyenv &.python-version
alias pev='pyenv'
alias pevv='pyenv virtualenv'
alias pea='pyenv_activate'
alias ped='pyenv deactivate'

function pyenv_init
  setenv PATH '/Users/maru/.pyenv/shims' $PATH
  setenv PYENV_SHELL fish
  . '/usr/local/Cellar/pyenv/1.0.6/libexec/../completions/pyenv.fish'
  command pyenv rehash 2>/dev/null
  function pyenv
    set command $argv[1]
    set -e argv[1]

    switch "$command"
    case activate deactivate rehash shell
      . (pyenv "sh-$command" $argv|psub)
    case '*'
      command pyenv "$command" $argv
    end
  end
end

function pyenv_virtualenv_init
  setenv PATH '/usr/local/Cellar/pyenv-virtualenv/1.0.0/shims' $PATH;
  setenv PYENV_VIRTUALENV_INIT 1;
  if [ -n "$VIRTUAL_ENV" ]
    pyenv activate --quiet; or pyenv deactivate --quiet; or true
  else
    pyenv activate --quiet; or true
  end
  return $status
end

function pyenv_activate
  pyenv_init
  pyenv_virtualenv_init
  [ (cat .python-version) = (basename "$PYENV_VIRTUAL_ENV") ]
end

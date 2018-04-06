alias node='node --use_strict';

# neovim
alias vim='nvim'; alias v='vim +F';
alias ta='tmux attach'
set PATH $PATH ~/.local/bin node_modules/.bin/ /Users/ahnheejong/.local/bin ~/.cargo/bin
export JAVA_HOME=(/usr/libexec/java_home)

# git remote
alias grau='git_remote_add_upstream'

function git_remote_add_upstream
  set account_name $argv[1]
  set repository_name $argv[2]
  git remote add upstream git@github.com:$account_name/$repository_name
end

# chips
if [ -e ~/.config/chips/build.fish ] ; source ~/.config/chips/build.fish ; end

# pyenv &.python-version
alias pev='pyenv'
alias pevv='pyenv virtualenv'
alias pea='pyenv_activate'
alias ped='pyenv deactivate'
alias pel='pyenv_local_setup'

function pyenv_local_setup
  set version $argv[1]
  set venv_name (basename $PWD)
  pyenv virtualenv $version $venv_name
  pyenv local $venv_name
  pyenv_activate
end

function pyenv_init
  setenv PATH '/Users/maru/.pyenv/shims' $PATH
  setenv PYENV_SHELL fish
  . '/usr/local/Cellar/pyenv/1.2.0/libexec/../completions/pyenv.fish'
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
  setenv PATH '/usr/local/Cellar/pyenv-virtualenv/1.1.1/shims' $PATH;
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

# chips
if [ -e ~/.config/chips/build.fish ] ; . ~/.config/chips/build.fish ; end

# Path to your oh-my-zsh installation.
export ZSH=${HOME}/.oh-my-zsh
export DEFAULT_USER="maru"
export EDITOR=/usr/local/bin/vim

export BULLETTRAIN_PROMPT_SEPARATE_LINE=false
export BULLETTRAIN_PROMPT_CHAR=$

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="bullet_train"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# User configuration

# export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/mysql/bin"
# export MANPATH="/usr/local/man:$MANPATH"

export PATH=$HOME/dev/flutter/bin:$HOME/.cargo/bin:$HOME/.fastlane/bin:$PATH:/usr/local/share/npm/bin
source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias clr='clear'
alias df='df -kTh'
alias grep='grep --color=auto --exclude-dir="\.git" --exclude-dir="\.svn"'
alias egrep='egrep --color=auto --exclude-dir="\.git" --exclude-dir="\.svn"'
alias fgrep='fgrep --color=auto --exclude-dir="\.git" --exclude-dir="\.svn"'
alias t1='tail -n1'
alias h1='head -n1'
alias vi='vim'
alias sbp="source_if_exists $HOME/.bash_profile"
alias hr="cd $HSR"
alias rakeit="rake db:drop && rake db:create && rake db:migrate && rake db:seed"
alias beeline="beeline --color=true"
alias tree="tree -I sandcube"
alias brew_cleaner="brew update && brew upgrade brew-cask && brew cleanup && brew cask cleanup"
alias gsquash=squash
alias hideme='history -d $((HISTCMD-1)) &&'
alias sc='soundcloud2000'
export GRC=`which grc 2>/dev/null`
if [ "$TERM" != dumb ] && [ -n GRC ]
then
  alias colourify="$GRC -es --colour=auto"
  alias mvnk="colourify -c $HOME/.grc/mvn.config mvn"
  alias kat="colourify -c $HOME/.grc/mvn.config"
fi

function source_if_exists() {
  for arg in $@; do
    if [[ -s $arg ]]; then
      if_debug_echo $arg
      source $arg
    else
      if_debug_echo "WARN NO $arg FOUND"
    fi
  done
}

function initialize_path() {
  if [[ -z $path_initialized ]] && [[ "$#" -eq 1 ]]; then
    if [[ -z $PATH ]]; then
      export PATH=$1
    else
      export PATH=$1:$PATH
    fi
  fi
}

function initialize_manpath() {
  if [[ -z $path_initialized ]] && [[ "$#" -eq 1 ]]; then
    if [[ -z $MANPATH ]]; then
      export MANPATH=$1
    else
      export MANPATH=$1:$MANPATH
    fi
  fi
}

function add_brew_paths() {
  for arg in $@; do
    if_debug_echo $arg
    initialize_path "`brew --prefix $arg`/libexec/gnubin"
    initialize_manpath "`brew --prefix $arg`/libexec/gnuman"
  done
}

function if_debug_echo() {
  if [[ "$debug_source" == true ]]; then
    echo $@
  fi
}

############################################################
# core functions
############################################################
function containsElement() {
  local e
  for e in "${@:2}"; do
    if [[ "$e" == "$1" ]]; then
      echo 1
      return 0 # bash exit code
      fi
  done
  echo 0
  return 1 # bash exit code
}

# Temporarily add directories to PATH
function add_path() {
  if [ $# -lt 1 ] || [ $# -gt 2 ]; then
    echo "Temporarily add to PATH"
    echo "usage: apath [dir]"
  else
    PATH=$1:$PATH
  fi
}

# Repeat n times command
function repeat() {
  local i max
  max=$1; shift;
  for ((i=1; i <= max ; i++)); do
    eval "$@";
  done
}

function watch_proc() {
  sleepy_time=1
  while true; do
    clear
    eval $*
    sleep $sleepy_time
  done
}

function ask() {
  echo -n "${RED}$@" '[y/n] ' "${RESET}" ; read ans
  case "$ans" in
    y*|Y*) return 0 ;;
    *) return 1 ;;
  esac
}

# get top fifteen most run commands
function bash_stat() {
  cut -f1 -d" " $HOME/.bash_history | sort | uniq -c | sort -nr | head -n 15
}

# ack history
function hack() {
  history | ack $1
}

function coalesce() {
  #TODO add error for all empty
  for arg in $@; do
    if [[ -n "$arg" ]]; then
      echo "$arg"
      break
    fi
  done
}

############################################################
# git helpers
############################################################
function git_url_parse() {
  echo $1 | sed -E 's#(git\@|https://)([^/:]+)(:|/)([^/]+)/(.+$)#'\\$2'#g'
}

function hub_or_git() {
  if command -v hub >/dev/null 2>&1; then
    command hub "$@"
  else
    command git "$@"
  fi
}

############################################################
# compressed file helpers
############################################################
# Handy Extract Program
function extract() {
  if [ -f $1 ] ; then
    case $1 in
     *.tar.bz2)   tar xvjf $1   ;;
     *.tar.gz)  tar xvzf $1   ;;
     *.bz2)     bunzip2 $1    ;;
     *.rar)     unrar x $1    ;;
     *.gz)    gunzip $1     ;;
     *.tar)     tar xvf $1    ;;
     *.tbz2)    tar xvjf $1   ;;
     *.tgz)     tar xvzf $1   ;;
     *.zip)     unzip $1    ;;
     *.Z)     uncompress $1   ;;
     *.7z)    7z x $1     ;;
     *)       echo "'$1' cannot be extracted via >extract<" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Creates an archive from given directory
mktar() { tar cvf  "${1%%/}.tar"   "${1%%/}/"; }
mktgz() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }
mktbz() { tar cvjf "${1%%/}.tar.bz2" "${1%%/}/"; }

############################################################
# file helpers
############################################################
# Swap 2 filenames around, if they exist
function swap() {
  local TMPFILE=tmp.$$

  [ $# -ne 2 ] && echo "swap: 2 arguments needed" && return 1
  [ ! -e $1 ] && echo "swap: $1 does not exist" && return 1
  [ ! -e $2 ] && echo "swap: $2 does not exist" && return 1

  mv "$1" $TMPFILE
  mv "$2" "$1"
  mv $TMPFILE "$2"
}

# changes filename to lowercase
function lowercase() {
  for file ; do
    filename=${file##*/}
    case "$filename" in
    */*) dirname==${file%/*} ;;
    *) dirname=.;;
    esac
    nf=$(echo $filename | tr A-Z a-z)
    newname="${dirname}/${nf}"
    if [ "$nf" != "$filename" ]; then
      mv "$file" "$newname"
      echo "lowercase: $file --> $newname"
    else
      echo "lowercase: $file not changed."
    fi
  done
}

# converts spaces in filename to _
function no_spaces() {
  for file ; do
    filename=${file##*/}
    case "$filename" in
    */*) dirname==${file%/*} ;;
    *) dirname=.;;
    esac
    nf=$(echo $filename | sed -E 's/[[:space:]]+/_/g')
    newname="${dirname}/${nf}"
    if [ "$nf" != "$filename" ]; then
      mv "$file" "$newname"
      echo "no_spaces: $file --> $newname"
    else
      echo "no_spaces: $file not changed."
    fi
  done
}

# finds all files and dirs in the pwd that have spaces in their name
# and renames them with all spaces converted to _
function nuke_spaces() {
  ruby -e 'files = Dir["./*"].select { |file| file.match(/ /) }
    files.each do |file|
      newname = file.gsub(/ /, "_")
      puts "nuke_spaces: #{file} --> #{newname}"
      File.rename(file, newname)
    end'
}

# Find a file from pwd with pattern $1 in name and Execute $2 on it
function find_exec() {
  # Check for proper number of command line args.
  EXPECTED_ARGS=2

  if [ $# -ne $EXPECTED_ARGS ]; then
    echo "ERROR: invaild # of args: Usage: fe pattern cmd"
  else
    find . -type f -iname '*'$1'*' -exec "${2:-file}" {} \; ;
  fi
}

function dirsize() {
  du -shx * .[a-zA-Z0-9_]* 2> /dev/null | \
  egrep '^ *[0-9.]*[MG]' | sort -n > /tmp/list
  egrep '^ *[0-9.]*M' /tmp/list
  egrep '^ *[0-9.]*G' /tmp/list
  rm -f /tmp/list
}

function mkcd() {
  mkdir -p $1 && cd $1
}

############################################################
# host and network helpers
############################################################
# Get IP address
function my_ip() {
  MY_IP=$(/sbin/ifconfig | awk '/inet/ { print $2 } ' | sed -e s/addr://)
}

# Get current host related info
function hi() {
  echo -e "${RED}You are logged on:${RESET}" ; hostname
  echo -e "\n${RED}Additionnal information:${RESET}" ; uname -a
  echo -e "\n${RED}Current date:${RESET} " ; date
  echo -e "\n${RED}Machine stats:${RESET}" ; uptime
  echo -e "\n${RED}Memory stats:${RESET}" ; free
  echo -e "\n${RED}Disk stats:${RESET}" ; df -kh
  my_ip 2>&- ;
  echo -e "\n${RED}Local IP Address:${RESET}" ; echo ${MY_IP:-"Not connected"}
  echo -e "\n${YELLOW}Users logged on:${RESET}" ; w -h
}

# network information
function ni() {
  echo "--------------- Network Information ---------------"
  /sbin/ifconfig
  echo "---------------------------------------------------"
  echo -e "\nOpen connections : "; netstat;
}

############################################################
# math helpers
############################################################
function trans() {
  awk '{
    for (i=1; i<=NF; i++) {
      a[NR,i] = $i
    }
  }
  NF>p { p = NF }
  END {
    for(j=1; j<=p; j++) {
      str=a[1,j]
      for(i=2; i<=NR; i++) {
        str=str" "a[i,j];
      }
      print str
    }
  }' $1
}

function add_col_rows() {
  awk '{total = total + $1} END{print total}' $1
}

############################################################
# misc
############################################################
function q_exit() {
  while true; do
    xit='null'
    echo "${INVIS}"; read -s -t 1 -n 1 xit
    if [ "$xit" == "q" ]; then
      echo "Good-bye?!${RESET}"; sleep 1; clear; echo "${VIS}"
      break
    else
      clear
      echo `${@}`
    fi
  done
}

function clock() {
  night_hours=('22' '23' '00' '01' '02' '03')
  Cnight_hours=('19' '20' '21' '04' '05' '06')
  timet=$(date +"%R" | sed -E 's/(.{2})/\1 /g' | awk /'/ {print $1}')

  if [[ $(containsElement "$timet" "${night_hours[@]}") -eq 1 ]]; then
    echo "${GREEN}${TXTBLD}"
  elif [[ $(containsElement "$timet" "${Cnight_hours[@]}") -eq 1 ]]; then
    echo "${BLUE}${TXTBLD}"
  else
    echo "${YELLOW}${TXTBLD}"
  fi
  echo -ne `date +"%r"`
}

# Linux only: Takes a screenshot of your size choice
function shot() {
  import -frame -strip -quality 75 "$HOME/$(date +%s).png"
}

############################################################
# mysql helpers
############################################################
function spl() {
  command mysql -e 'show processlist' | egrep $1
}

function mysql_find_col() {
  EXPECTED_ARGS=2
  if [ $# -ne $EXPECTED_ARGS ]; then
    echo "ERROR invalid # of args"
    echo "Usage: `basename $0` DBs cols"
    return 65
  fi

  echo "mysql_find_col: searching dbs:$1 for $2"
  command mysql -e "SELECT TABLE_SCHEMA, TABLE_NAME, \
    group_concat(COLUMN_NAME) MATCHING_COLUMNS \
    FROM INFORMATION_SCHEMA.COLUMNS \
    WHERE COLUMN_NAME regexp '$2' \
      and TABLE_SCHEMA regexp '$1' \
    group by 1, 2;"
}

# actually show real hostname in prompt
# even if a localhost connection
function mysql() {
  export mysql_args="$@"
  remote_connection=`ruby -e 'p ENV["mysql_args"].match(/\s*-h\s/) ? true : false'`

  if [[ "$remote_connection" == true ]]; then
    export MYSQL_PS1="[mysql] \u@\h:\d> "
  else
    mysql_hostname=`hostname | sed -E 's/\..+$//'`
    export MYSQL_PS1="[mysql] \u@$mysql_hostname:\d> "
  fi

  if command -v grcat >/dev/null 2>&1; then
    command mysql "$@" --pager='grcat $HOME/.grc/sql.config'
  else
    command mysql "$@"
  fi
}

############################################################
# process helpers
############################################################
function my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,bsdtime,command ; }

# Kill by process name
function killps() {
  local pid pname sig="-TERM"   # Default signal
  if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
    echo "Usage: killps [-SIGNAL] pattern"
    return;
  fi
  if [ $# = 2 ]; then sig=$1 ; fi
  for pid in $(my_ps| awk '!/awk/ && $0~pat { print $1 }' pat=${!#} ) ; do
    pname=$(my_ps | awk '$1~var { print $5 }' var=$pid )
    if ask "Kill process $pid <$pname> with signal $sig?"
      then kill -9 $pid
    fi
  done
}

############################################################
# style helpers
############################################################
function colortest() {
  echo "${BLACK} TEST test ${TXTBLD} TEST test ${RESET}"
  echo "${RED} TEST test ${TXTBLD} TEST test ${RESET}"
  echo "${GREEN} TEST test ${TXTBLD} TEST test ${RESET}"
  echo "${YELLOW} TEST test ${TXTBLD} TEST test ${RESET}"
  echo "${BLUE} TEST test ${TXTBLD} TEST test ${RESET}"
  echo "${PURPLE} TEST test ${TXTBLD} TEST test ${RESET}"
  echo "${CYAN} TEST test ${TXTBLD} TEST test ${RESET}"
  echo "${WHITE} TEST test ${TXTBLD} TEST test ${RESET}"
}

function colortest2() {
  for i in {0..255} ; do
    printf "\x1b[38;5;${i}mcolour${i}\n"
  done
}

############################################################
# tmux helpers
############################################################
# window renamer for tmux
function ssh() {
  if [[ -z $TMUX ]]; then
    command ssh $@
  elif [[ ! -z $TMUX ]] && [[ -z $tmux_ssh_rename_enabled ]]; then
    command ssh $@
  else
    local remote=`echo $* | sed 's/\..*$//'`
    local old_name="$(tmux display-message -p '#W')"
    local renamed=0
    # Save the current name
    if [[ $remote != -* ]]; then
      renamed=1
      tmux rename-window $remote
    fi
    command ssh $@
    if [[ $renamed == 1 ]]; then
      tmux rename-window "$old_name"
    fi
  fi
}

function battery_health() {
  HEART='♥'
  num_hearts=20

  if [[ `uname` == 'Linux' ]]; then
    current_charge=$(cat /proc/acpi/battery/BAT1/state | grep 'remaining capacity' | awk '{print $3}')
    total_charge=$(cat /proc/acpi/battery/BAT1/info | grep 'last full capacity' | awk '{print $4}')
  else
    battery_info=`ioreg -rc AppleSmartBattery`
    current_charge=$(echo $battery_info | grep -o '"CurrentCapacity" = [0-9]\+' | awk '{print $3}')
    total_charge=$(echo $battery_info | grep -o '"MaxCapacity" = [0-9]\+' | awk '{print $3}')
  fi

  charged_slots=$(echo "(($current_charge/$total_charge)*$num_hearts)+1" | bc -l | cut -d '.' -f 1)
  if [[ $charged_slots -gt $num_hearts ]]; then
    charged_slots=$num_hearts
  fi

  echo -n '#[fg=colour196]'
  for i in `seq 1 $charged_slots`; do echo -n "$HEART"; done

  if [[ $charged_slots -lt $num_hearts ]]; then
    echo -n '#[fg=white]'
    for i in `seq 1 $(echo "$num_hearts-$charged_slots" | bc)`; do echo -n "$HEART"; done
  fi
}

function squash() {
  if [ -n "$1" ]; then
    git reset --soft HEAD~$1 && git commit --edit -m"$(git log --format=%B --reverse HEAD..HEAD@{1})"
  else
    echo "Please provide a number of commits to squash"
  fi
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /Users/maru/workspace/nevermind/router/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/maru/workspace/nevermind/router/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /Users/maru/workspace/nevermind/router/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/maru/workspace/nevermind/router/node_modules/tabtab/.completions/sls.zsh
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[[ -f /Users/maru/workspace/nevermind/router/node_modules/tabtab/.completions/slss.zsh ]] && . /Users/maru/workspace/nevermind/router/node_modules/tabtab/.completions/slss.zsh

# added by travis gem
[ -f /Users/maru/.travis/travis.sh ] && source /Users/maru/.travis/travis.sh

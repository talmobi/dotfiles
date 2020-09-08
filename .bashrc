# fix for scp / rsync ( don't do anything if terminal isn't human basically )
case $- in
  *i*) ;;
  *) return;;
esac

unameOut="$(uname -s)"
case "${unameOut}" in
  Linux*)   machine=Linux;;
  Darwin*)   machine=Mac;;
  CYGWIN*)   machine=Cygwin;;
  MINGW*)   machine=MinGw;;
  *)   machine="UNKNOWN:${unameOut}";;
esac

isWindows=1

alias ls='ls -G'

if  [ $machine = Mac ] ; then
  alias ls='ls -G'
  isWindows=0
elif  [ $machine = Linux ]  ; then
  alias ls='ls --color'
  isWindows=0
elif [ $machine = MinGw ] || [ $machine = Cygwin ] ; then
  alias ls='ls --color'
  isWindows=1
fi

echo "BASH_VERSION: $BASH_VERSION"
echo "Machine: $machine"

# if [ $ncolors -ge 256 ]; then
if [ -t 1 ]; then
  if [ $TERM = xterm ]; then
    export TERM=xterm-256color
  else
    export TERM=screen-256color
  fi
fi

# fix irssi corrupted scrolling
alias irssi='TERM=screen irssi'

# if on windows
if [ $isWindows -eq 1 ]; then
  export TERM=xterm
  export FORCE_COLOR=true
fi

echo "TERM: $TERM"

ncolors=$(tput colors)
echo "ncolors: $ncolors"

alias jap="grep . ~/dotfiles/jap/* | nfzf"
alias tips="grep . ~/dotfiles/scripts/tips.txt | nfzf"

alias sf="rg --files | fzf"
alias saf="find . | fzf"

alias tree="tree -I 'node_modules'"

alias gist="ls -1 ~/dotfiles/gists/* | fzf --exit-0 --bind 'enter:execute(vim --not-a-term -- {})+abort'"

alias gitcheckout="git branch | sed s/*//g | sed s/\ //g | nfzf --normal | xargs git checkout"
alias gitmerge="git branch | sed s/*//g | sed s/\ //g | nfzf --normal | xargs git merge"
alias gitlog="git log --all --graph --decorate --oneline"

# https://www.cyberciti.biz/faq/how-do-i-find-the-largest-filesdirectories-on-a-linuxunixbsd-filesystem/
# get top 10 files/dirs eting disc space
alias ducks="du -cks * | sort -n | head"
alias duke100="du -k * | awk '$1 > 100000' | sort -nr"

# never again...
alias gti=git

alias h='history'
export HISTIGNORE='history:clear:h:jap:tips'

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
# also important for tmux @resurrect-save-shell-history to prevent duplicates
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=99999
HISTFILESIZE=99999

if [ -x "$(command -v vim)" ]; then
  export EDITOR=vim
fi

# refresh tmux pane in case of tty corruption
tmux-refresh() {
  stty sane; printf '\033k%s\033\\\033]2;%s\007' "$(basename "$SHELL")" "$(uname -n)"; tput reset; tmux refresh
}

# export PROMPT_COMMAND="history -a; history -n"

# export FZF_DEFAULT_COMMAND='find . | grep --exclude=vim'
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# https://github.com/junegunn/fzf/issues/816
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden --bind '?:toggle-preview' --bind 'ctrl-y:execute(echo -n {2..} | pbcopy)' --header 'Press CTRL-Y to copy command into clipboard'"

# . `brew --prefix`/etc/profile.d/z.sh

function parse_git_branch {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# prepend android sdk and tools to PATH
export PATH=$PATH:/Users/mollie/Library/Android/sdk/platform-tools:/Users/mollie/Library/Android/sdk/tools:$PATH

# postgres PATH
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin

# dotfiles scripts path
export PATH=$PATH:~/dotfiles/sh

# common npm global packages installation diretory
# ref: https://github.com/sindresorhus/guides/blob/master/npm-global-without-sudo.md
# ref: https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally
export PATH=:~/.npm-packages/bin:$PATH
export PATH=:~/.npm-global/bin:$PATH

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# enable bash completion in interactive shells
# if ! shopt -oq posix; then
#   if [ -f /usr/share/bash-completion/bash_completion ]; then
#     . /usr/share/bash-completion/bash_completion
#   elif [ -f /etc/bash_completion ]; then
#     . /etc/bash_completion
#   fi
# fi

# get current branch in git repo
function parse_git_branch2 {
  BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
  if [ ! "${BRANCH}" == "" ]
  then
    # STAT=`parse_git_dirty`
    # echo "[${BRANCH}${STAT}]"
    echo "(${BRANCH})"
  else
    echo ""
  fi
}

# get current status of git repo
function parse_git_dirty {
  status=`git status 2>&1 | tee`
  dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
  untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
  ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
  newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
  renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
  deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
  bits=''
  if [ "${renamed}" == "0" ]; then
    bits=">${bits}"
  fi
  if [ "${ahead}" == "0" ]; then
    bits="*${bits}"
  fi
  if [ "${newfile}" == "0" ]; then
    bits="+${bits}"
  fi
  if [ "${untracked}" == "0" ]; then
    bits="?${bits}"
  fi
  if [ "${deleted}" == "0" ]; then
    bits="x${bits}"
  fi
  if [ "${dirty}" == "0" ]; then
    bits="!${bits}"
  fi
  if [ ! "${bits}" == "" ]; then
    echo " ${bits}"
  else
    echo ""
  fi
}

# export PS1="\u\W\`parse_git_branch\` "

if [ $isWindows -eq 0 ]; then
  export PS1='\e[0;32m \u \e[m\e[0;33m \w \e[m\e[1;33m$(parse_git_branch2)\e[m\n\$ '
else
  export PS1='\e[0;32m \u@\h\e[m\e[0;35m \s\e[m\e[0;33m \w\e[m \e[1;36m`parse_git_branch2`\e[m\n\$ '
  # export PS1='\e[0;32m \u \e[m\e[0;33m \w \e[m\e[1;33m$(parse_git_branch)\e[m\n\$ '
fi


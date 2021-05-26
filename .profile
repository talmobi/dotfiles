export LC_ALL=en_US.UTF-8
export BASH_SILENCE_DEPRECATION_WARNING=1

# prepend android sdk and tools to PATH
export PATH=/Users/mollie/Library/Android/sdk/platform-tools:/Users/mollie/Library/Android/sdk/tools:$PATH

export PATH=/Users/mollie/go/bin:$PATH

# postgres PATH
export PATH=/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH

# dotfiles scripts path
export PATH=~/dotfiles/sh:$PATH

# common npm global packages installation diretory
# ref: https://github.com/sindresorhus/guides/blob/master/npm-global-without-sudo.md
# ref: https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally
export PATH=~/.npm-packages/bin:$PATH
export PATH=~/.npm-global/bin:$PATH

# homebrew bin
export PATH="$(brew --prefix)/bin":$PATH

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

# export FZF_DEFAULT_COMMAND='find . | grep --exclude=vim'
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# https://github.com/junegunn/fzf/issues/816
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden --bind '?:toggle-preview' --bind 'ctrl-y:execute(echo -n {2..} | pbcopy)' --header 'Press CTRL-Y to copy command into clipboard'"

# add linuxbrew to env
test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

eval "$(/opt/homebrew/bin/brew shellenv)"

eval "$(direnv hook bash)"

$(brew --prefix asdf)/asdf.sh

$(brew --prefix asdf)/etc/bash_completion.d/asdf.bash

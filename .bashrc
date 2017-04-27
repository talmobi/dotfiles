PS1='\e[0;32m \u \e[m\e[0;33m \w \e[m \n\$ '

alias ls='ls -G'
alias h='history'
export HISTIGNORE='history:clear:h'
alias tree="tree -I 'node_modules'"
export TERM=xterm-256color

# refresh tmux pane in case of tty corruption
tmux-refresh() {
  stty sane; printf '\033k%s\033\\\033]2;%s\007' "$(basename "$SHELL")" "$(uname -n)"; tput reset; tmux refresh
}

# . `brew --prefix`/etc/profile.d/z.sh

# prepend android sdk and tools to PATH
export PATH=/Users/mollie/Library/Android/sdk/platform-tools:/Users/mollie/Library/Android/sdk/tools:$PATH

# postgres PATH
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin

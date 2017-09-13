alias ls='ls -G'
alias h='history'
export HISTIGNORE='history:clear:h'
alias tree="tree -I 'node_modules'"
export TERM=xterm-256color

alias jap="grep . ~/dotfiles/jap/* | fzf"

# https://www.cyberciti.biz/faq/how-do-i-find-the-largest-filesdirectories-on-a-linuxunixbsd-filesystem/
# get top 10 files/dirs eting disc space
alias ducks="du -cks * | sort -n | head"

alias duke100="du -k * | awk '$1 > 100000' | sort -nr"

# refresh tmux pane in case of tty corruption
tmux-refresh() {
  stty sane; printf '\033k%s\033\\\033]2;%s\007' "$(basename "$SHELL")" "$(uname -n)"; tput reset; tmux refresh
}

export PROMPT_COMMAND="history -a; history -n"

export FZF_DEFAULT_COMMAND='rg --files'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# . `brew --prefix`/etc/profile.d/z.sh

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# prepend android sdk and tools to PATH
export PATH=$PATH:/Users/mollie/Library/Android/sdk/platform-tools:/Users/mollie/Library/Android/sdk/tools:$PATH

# postgres PATH
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin

export PS1='\e[0;32m \u \e[m\e[0;33m \w \e[m\e[1;33m$(parse_git_branch)\e[m\n\$ '

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

echo "in profile"

# disbale ctrl-d for closing windows/sessions accidentally
set -o ignoreeof

# reset PATH to default
export PATH=/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

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

# add linuxbrew to env if exists
test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

eval "$(/opt/homebrew/bin/brew shellenv)"

# $(brew --prefix asdf)/asdf.sh

# ref: https://www.npmjs.com/package/n
export N_PREFIX=~/.n        # n install path
export PATH=~/.n/bin:$PATH  # add node versions downloaded by n to PATH

# test -d ~/var/log/ && (
#     echo "$(date): .profile: $0: $$"; pstree -lp $PPID 2>/dev/null
#     echo "BASH_SOURCE: ${BASH_SOURCE[*]}"
#     echo "FUNCNAME: ${FUNCNAME[*]}"
#     echo "BASH_LINENO: ${BASH_LINENO[*]}"
# ) >> ~/var/log/config-scripts.log

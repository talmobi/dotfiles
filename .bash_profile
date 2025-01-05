PROFILE=~/.profile
if test -f "$PROFILE"; then
  . ~/.profile
fi
. ~/.bashrc

# (
#     echo "$(date): .bash_profile: $0: $$"; pstree -lp $PPID 2>/dev/null
#     echo "BASH_SOURCE: ${BASH_SOURCE[*]}"
#     echo "FUNCNAME: ${FUNCNAME[*]}"
#     echo "BASH_LINENO: ${BASH_LINENO[*]}"
# ) >> ~/var/log/config-scripts.log

eval "$(/opt/homebrew/bin/brew shellenv)"

npm set prefix '~/npm-global'
export PATH="~/npm-global/bin:$PATH"

export N_PREFIX=~/.n          # n install path
export PATH=~/.n/bin:$PATH    # add node versions downloaded by n to PATH

if test -f "$HOME/.cargo/env"; then
  . "$HOME/.cargo/env"
fi

export LC_ALL=en_US.UTF-8
export BASH_SILENCE_DEPRECATION_WARNING=1

eval "$(/opt/homebrew/bin/brew shellenv)"

eval "$(direnv hook bash)"

$(brew --prefix asdf)/asdf.sh

$(brew --prefix asdf)/etc/bash_completion.d/asdf.bash

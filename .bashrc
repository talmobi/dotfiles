PS1='\e[0;32m \u \e[m\e[0;33m \w \e[m \n\$ '
alias ls='ls -G'
alias h='history'
export HISTIGNORE='history:clear:h'
export tree="tree -I 'node_modules'"

# prepend android sdk and tools to PATH
export PATH=/Users/mollie/Library/Android/sdk/platform-tools:/Users/mollie/Library/Android/sdk/tools:$PATH

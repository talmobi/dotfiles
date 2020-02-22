source ~/.bashrc

export LC_ALL=en_US.UTF-8

export PATH=/usr/local/sbin:$PATH

##
# Your previous /Users/mollie/.bash_profile file was backed up as /Users/mollie/.bash_profile.macports-saved_2018-04-25_at_22:14:12
##

# MacPorts Installer addition on 2018-04-25_at_22:14:12: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/mollie/Downloads/google-cloud-sdk/path.bash.inc' ]; then . '/Users/mollie/Downloads/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/mollie/Downloads/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/mollie/Downloads/google-cloud-sdk/completion.bash.inc'; fi

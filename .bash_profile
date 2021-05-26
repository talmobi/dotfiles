. ~/.profile
. ~/.bashrc

(
    echo "$(date): .bash_profile: $0: $$"; pstree -lp $PPID 2>/dev/null
    echo "BASH_SOURCE: ${BASH_SOURCE[*]}"
    echo "FUNCNAME: ${FUNCNAME[*]}"
    echo "BASH_LINENO: ${BASH_LINENO[*]}"
) >> ~/var/log/config-scripts.log

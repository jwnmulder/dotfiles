if (( $+commands[batcat] )); then
    alias cat='batcat --paging=never --plain'
    alias bat='batcat'
elif (( $+commands[bat] )); then
    alias cat='bat --paging=never --plain'
fi

alias wget='wget --hsts-file="$XDG_DATA_HOME"/wget-hsts'

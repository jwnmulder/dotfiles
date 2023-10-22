if (( $+commands[bat] )); then
    alias cat='bat --paging=never --plain'
elif (( $+commands[batcat] )); then
    alias cat='batcat --paging=never --plain'
    alias bat='batcat'
fi

alias wget='wget --hsts-file="$XDG_DATA_HOME"/wget-hsts'

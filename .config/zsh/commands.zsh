if (( $+commands[batcat] )); then
    alias cat='batcat --paging=never'
    alias bat='batcat'
elif (( $+commands[bat] )); then
    alias cat='bat --paging=never'
fi
